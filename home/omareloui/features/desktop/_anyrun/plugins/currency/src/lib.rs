use abi_stable::std_types::{RString, RVec, ROption};
use anyrun_plugin::*;
use once_cell::sync::Lazy;
use regex::Regex;
use serde::Deserialize;
use std::collections::HashMap;
use std::sync::Mutex;

#[derive(Deserialize)]
struct ExchangeRates {
    rates: HashMap<String, f64>,
}

struct PluginState {
    rates: HashMap<String, f64>,
}

static STATE: Lazy<Mutex<PluginState>> = Lazy::new(|| {
    Mutex::new(PluginState {
        rates: HashMap::new(),
    })
});

static INPUT_REGEX: Lazy<Regex> = Lazy::new(|| {
    Regex::new(r"^(\d+(?:\.\d+)?)\s*([A-Za-z]{3})\s+(?:to\s+)?([A-Za-z]{3})$").unwrap()
});

#[init]
fn init(_config_dir: RString) -> anyhow::Result<()> {
    let client = reqwest::blocking::Client::new();
    let response = client
        .get("https://api.exchangerate-api.com/v4/latest/USD")
        .send()?
        .json::<ExchangeRates>()?;
    
    let mut state = STATE.lock().unwrap();
    state.rates = response.rates;
    Ok(())
}

#[info]
fn info() -> PluginInfo {
    PluginInfo {
        name: "Currency Converter".into(),
        icon: "accessories-calculator".into(),
    }
}

#[get_matches]
fn get_matches(input: RString) -> RVec<Match> {
    let input_str = input.as_str();
    let state = STATE.lock().unwrap();
    
    if let Some(captures) = INPUT_REGEX.captures(input_str) {
        let amount: f64 = captures[1].parse().unwrap_or(1.0);
        let from_currency = captures[2].to_uppercase();
        let to_currency = captures[3].to_uppercase();
        
        if let (Some(from_rate), Some(to_rate)) = (
            state.rates.get(&from_currency),
            state.rates.get(&to_currency),
        ) {
            let converted = (amount / from_rate) * to_rate;
            let result = format!("{:.2} {} = {:.2} {}", 
                amount, from_currency, converted, to_currency);
            
            return vec![Match {
                id: ROption::RNone,
                icon:  ROption::RNone,
                title: format!("{:.2}", converted).into(),
                use_pango: false,
                description: ROption::RSome(result.into()),
            }].into();
        }
    }
    
    vec![].into()
}

#[handler]
fn handler(selection: Match) -> HandleResult {
    HandleResult::Copy(selection.title.into_bytes())
}
