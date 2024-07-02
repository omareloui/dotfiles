#! /usr/bin/python
'''
Rounder 0.4
Based in deprecated "Path Rounder 0.2"
Based in  radiusrand script from Aaron Spike and make it by Jabier Arraiza, 
jabier.arraiza@marker.es
Copyright (C) 2005 Aaron Spike, aaron@ekips.org

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
'''
import random, math, inkex, cubicsuperpath, re

class svgRounder(inkex.Effect):
    def __init__(self):
        inkex.Effect.__init__(self)
        self.OptionParser.add_option("--p","--precision",
                             action="store", type="int",
                             dest="precision", default=3,
                             help="Precision")
        self.OptionParser.add_option("-c", "--ctrl",
                        action="store", type="inkbool", 
                        dest="ctrl", default = False,
                        help="Round node handles")
        self.OptionParser.add_option("-a", "--along",
                        action="store", type="inkbool", 
                        dest="along", default = True,
                        help="Move handles following node movement")
        self.OptionParser.add_option("--half",
                        action="store", type="inkbool", 
                        dest="half", default = False,
                        help="Allow round to half if nearest")
        self.OptionParser.add_option("-p", "--paths",
                        action="store", type="inkbool", 
                        dest="paths", default = True,
                        help="Affect to paths")
        self.OptionParser.add_option("-w", "--widthheight",
                        action="store", type="inkbool", 
                        dest="widthheight", default = False,
                        help="Affect to width and height of objects")
        self.OptionParser.add_option("-x", "--position",
                        action="store", type="inkbool", 
                        dest="position", default = False,
                        help="Affect to position of objects")
        self.OptionParser.add_option("-s", "--strokewidth",
                        action="store", type="inkbool", 
                        dest="strokewidth", default = False,
                        help="Affect to stroke width of objects")
        self.OptionParser.add_option("-o", "--opacity",
                        action="store", type="inkbool", 
                        dest="opacity", default = False,
                        help="Affect to global opacity of objects")
        self.OptionParser.add_option("--strokeopacity",
                        action="store", type="inkbool", 
                        dest="strokeopacity", default = False,
                        help="Affect to stroke opcacity of objects")
        self.OptionParser.add_option("--fillopacity",
                        action="store", type="inkbool", 
                        dest="fillopacity", default = False,
                        help="Affect to fill opcacity of objects")

    def roundFloat(self, n):
        if self.options.half:
            if self.options.precision == 0:
                return str(round(n * 2) / 2)
            else:
                return str(round(n * (self.options.precision) * 10 * 2) / ((self.options.precision) * 10 * 2))
        else:
            return str(round(n,  self.options.precision))
 
    def roundit(self, p):
        x = self.roundFloat(p[0])
        y = self.roundFloat(p[1])
        return [float(x) - p[0], float(y) - p[1]]
    
    def path_round_it(self,node):
        if node.tag == inkex.addNS('path','svg'):
            d = node.get('d')
            p = cubicsuperpath.parsePath(d)
            for subpath in p:
                for csp in subpath:
                    delta = self.roundit(csp[1])
                    if self.options.along:
                        csp[0][0]+=delta[0] 
                        csp[0][1]+=delta[1] 
                    csp[1][0]+=delta[0] 
                    csp[1][1]+=delta[1] 
                    if self.options.along:
                        csp[2][0]+=delta[0] 
                        csp[2][1]+=delta[1] 
                    if self.options.ctrl:
                        delta = self.roundit(csp[0])
                        csp[0][0]+=delta[0] 
                        csp[0][1]+=delta[1] 
                        delta = self.roundit(csp[2])
                        csp[2][0]+=delta[0] 
                        csp[2][1]+=delta[1] 
            node.set('d',cubicsuperpath.formatPath(p))
        elif node.tag == inkex.addNS('g','svg'):
            for e in node:
                self.path_round_it(e)

    def roundStroke(self,matchobj):
        return 'stroke-width:' + self.roundFloat(float( matchobj.group(1))) +  matchobj.group(2);

    def roundOpacity(self,matchobj):
        return matchobj.group(1) + matchobj.group(2) + self.roundFloat(float( matchobj.group(3))) +  matchobj.group(4);

    def roundWHXY(self,matchobj):
        return matchobj.group(1) + self.roundFloat(float( matchobj.group(2))) +  matchobj.group(3);


    def stroke_round_it(self, node):
        if node.tag == inkex.addNS('g','svg'):
            for e in node:
                self.stroke_round_it(e)
        else:
            style = node.get('style')
            if style:
                style = re.sub('stroke-width:(.*?)(;|$)',self.roundStroke, style)
                node.set('style',style)
    def opacity_round_it(self, node, typeOpacity):
        if node.tag == inkex.addNS('g','svg'):
            for e in node:
                self.opacity_round_it(e)
        else:
            style = node.get('style')
            if style:
                style = re.sub('(^|;)(' + typeOpacity + ':)(.*?)(;|$)',self.roundOpacity, style)
                node.set('style',style)

    def widthheight_round_it(self, node):
        if node.tag == inkex.addNS('g','svg'):
            for e in node:
                self.widthheight_round_it(e)
        else:
            width = node.get('width')
            if width:
                width = re.sub('^(\-|)([0-9]+\.[0-9]+)(.*?)$',self.roundWHXY, width)
                node.set('width',width)
            height = node.get('height')
            if height:
                height = re.sub('^(\-|)([0-9]+\.[0-9]+)(.*?)$',self.roundWHXY, height)
                node.set('height',height)
    
    def position_round_it(self, node):
        if node.tag == inkex.addNS('g','svg'):
            for e in node:
                self.position_round_it(e)
        else:
            x = node.get('x')
            if x:
                x = re.sub('^(\-|)([0-9]+\.[0-9]+)(.*?)$',self.roundWHXY, x)
                node.set('x', x)
            y = node.get('y')
            if y:
                y = re.sub('^(\-|)([0-9]+\.[0-9]+)(.*?)$',self.roundWHXY, y)
                node.set('y', y)
    
    def effect(self):
        for id, node in self.selected.iteritems():
            if self.options.paths:
                self.path_round_it(node)
            if self.options.strokewidth:
                self.stroke_round_it(node)
            if self.options.widthheight:
                self.widthheight_round_it(node)
            if self.options.position:
                self.position_round_it(node)
            if self.options.opacity:
                self.opacity_round_it(node, "opacity")
            if self.options.strokeopacity:
                self.opacity_round_it(node, "stroke-opacity")
            if self.options.fillopacity:
                self.opacity_round_it(node, "fill-opacity")

if __name__ == '__main__':
    e = svgRounder()
    e.affect()


# vim: expandtab shiftwidth=4 tabstop=8 softtabstop=4 fileencoding=utf-8 textwidth=99
