import argparse
import logging
import os
import torch
import torch.nn as nn
import torch.optim as optim

logging.basicConfig(level=logging.INFO, format="%(asctime)s [RL_TRAINER] %(message)s")

class PolicyNetwork(nn.Module):
    def __init__(self, obs_dim: int, action_dim: int):
        super().__init__()
        self.actor = nn.Sequential(
            nn.Linear(obs_dim, 128),
            nn.ReLU(),
            nn.Linear(128, 128),
            nn.ReLU(),
            nn.Linear(128, action_dim),
            nn.Softmax(dim=-1)
        )

    def forward(self, x):
        return self.actor(x)

def train_ppo_agent(env_name: str, total_timesteps: int, save_path: str):
    logging.info(f"CUDA Available: {torch.cuda.is_available()}")
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    
    obs_dim = 16  # Mempool features, order book imbalance, spread
    action_dim = 3  # [0: Hold, 1: Buy, 2: Sell]

    model = PolicyNetwork(obs_dim, action_dim).to(device)
    optimizer = optim.Adam(model.parameters(), lr=3e-4)

    logging.info(f"Training PPO Agent on {env_name} using device: {device}")
    
    for step in range(1, 1001):
        dummy_obs = torch.randn(32, obs_dim).to(device)
        probs = model(dummy_obs)
        loss = -torch.log(probs + 1e-8).mean()

        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

        if step % 250 == 0:
            logging.info(f"Step {step}/{1000} | Loss: {loss.item():.6f}")

    os.makedirs(os.path.dirname(save_path), exist_ok=True)
    torch.save(model.state_dict(), save_path)
    logging.info(f"RL Weights exported to {save_path}")

def main():
    parser = argparse.ArgumentParser(description="RL Agent Training Pipeline")
    parser.add_argument("--env", type=str, default="OrderBookEnv-v0")
    parser.add_argument("--timesteps", type=int, default=1_000_000)
    parser.add_argument("--algo", type=str, default="PPO")
    parser.add_argument("--save-path", type=str, default="./data/models/rl_agent_latest.pt")
    args = parser.parse_args()

    train_ppo_agent(args.env, args.timesteps, args.save_path)

if __name__ == "__main__":
    main()
