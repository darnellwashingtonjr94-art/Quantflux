import argparse
import numpy as np
import logging

logging.basicConfig(level=logging.INFO, format="%(asctime)s [RISK_SIM] %(message)s")

def run_monte_carlo(portfolio_value: float, volatility: float, days: int, simulations: int) -> dict:
    logging.info(f"Running {simulations:,} Monte Carlo iterations over {days}-day horizon...")
    
    dt = 1 / 365
    drift = 0.05
    
    # Generate random paths
    shocks = np.random.normal(
        (drift - 0.5 * volatility ** 2) * dt,
        volatility * np.sqrt(dt),
        (simulations, days)
    )
    
    price_paths = portfolio_value * np.exp(np.cumsum(shocks, axis=1))
    final_values = price_paths[:, -1]
    
    var_95 = portfolio_value - np.percentile(final_values, 5)
    var_99 = portfolio_value - np.percentile(final_values, 1)
    
    return {
        "portfolio_value": portfolio_value,
        "mean_expected": float(np.mean(final_values)),
        "var_95_usd": float(var_95),
        "var_99_usd": float(var_99),
        "worst_case_drawdown": float(portfolio_value - np.min(final_values))
    }

def main():
    parser = argparse.ArgumentParser(description="Monte Carlo Portfolio Risk Simulator")
    parser.add_argument("--method", type=str, default="monte_carlo", choices=["monte_carlo", "historical_shocks"])
    parser.add_argument("--portfolio-value", type=float, default=1_000_000.0)
    args = parser.parse_args()

    results = run_monte_carlo(args.portfolio_value, volatility=0.65, days=14, simulations=50_000)
    
    logging.info(f"=== Simulation Metrics ({args.method.upper()}) ===")
    logging.info(f"Portfolio Base: ${results['portfolio_value']:,.2f}")
    logging.info(f"95% Confidence VaR: ${results['var_95_usd']:,.2f}")
    logging.info(f"99% Confidence VaR: ${results['var_99_usd']:,.2f}")
    logging.info(f"Worst Case Simulation Drawdown: ${results['worst_case_drawdown']:,.2f}")

if __name__ == "__main__":
    main()
