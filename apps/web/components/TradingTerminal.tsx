"use client";

import React, { useState } from "react";
import { ArrowUpRight, ArrowDownRight, Send } from "lucide-react";

export default function TradingTerminal() {
  const [symbol, setSymbol] = useState("MONAD-PERP");
  const [amount, setAmount] = useState("10.0");
  const [side, setSide] = useState<"BUY" | "SELL">("BUY");
  const [logs, setLogs] = useState<string[]>([
    "[SYSTEM] Engine initialized.",
    "[SOR] Route mapped to Monad Parallel Execution Pool."
  ]);

  const handleOrder = (e: React.FormEvent) => {
    e.preventDefault();
    const timestamp = new Date().toISOString().substring(11, 19);
    const newLog = `[${timestamp}] EXEC ${side} ${amount} ${symbol} @ MARKET [SUCCESS]`;
    setLogs((prev) => [newLog, ...prev.slice(0, 9)]);
  };

  return (
    <div className="bg-slate-900 border border-slate-800 rounded-lg p-5 flex flex-col gap-4">
      <div className="flex justify-between items-center border-b border-slate-800 pb-3">
        <h2 className="text-sm font-semibold text-slate-300 uppercase tracking-wider">
          Smart Order Execution Router
        </h2>
        <span className="text-xs text-emerald-400 font-mono">MONAD-TESTNET // CHAIN-10143</span>
      </div>

      <form onSubmit={handleOrder} className="grid grid-cols-4 gap-4 items-end">
        <div>
          <label className="text-xs text-slate-400 block mb-1">Asset Pair</label>
          <input
            type="text"
            value={symbol}
            onChange={(e) => setSymbol(e.target.value)}
            className="w-full bg-slate-950 border border-slate-800 rounded p-2 text-xs text-slate-200 focus:outline-none focus:border-cyan-500"
          />
        </div>
        <div>
          <label className="text-xs text-slate-400 block mb-1">Size (Units)</label>
          <input
            type="text"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
            className="w-full bg-slate-950 border border-slate-800 rounded p-2 text-xs text-slate-200 focus:outline-none focus:border-cyan-500"
          />
        </div>
        <div>
          <label className="text-xs text-slate-400 block mb-1">Side</label>
          <div className="grid grid-cols-2 gap-1 bg-slate-950 p-1 rounded border border-slate-800">
            <button
              type="button"
              onClick={() => setSide("BUY")}
              className={`text-xs py-1 rounded font-bold transition-colors ${
                side === "BUY" ? "bg-emerald-600 text-white" : "text-slate-400"
              }`}
            >
              BUY
            </button>
            <button
              type="button"
              onClick={() => setSide("SELL")}
              className={`text-xs py-1 rounded font-bold transition-colors ${
                side === "SELL" ? "bg-rose-600 text-white" : "text-slate-400"
              }`}
            >
              SELL
            </button>
          </div>
        </div>
        <button
          type="submit"
          className="bg-cyan-600 hover:bg-cyan-500 text-slate-950 font-bold py-2 rounded text-xs flex items-center justify-center gap-2 transition-all"
        >
          <Send className="w-3.5 h-3.5" />
          DISPATCH
        </button>
      </form>

      {/* Console Feed */}
      <div className="bg-slate-950 rounded border border-slate-850 p-3 h-32 overflow-y-auto font-mono text-xs text-slate-400 flex flex-col gap-1">
        {logs.map((log, idx) => (
          <div key={idx} className={log.includes("EXEC") ? "text-cyan-300" : "text-slate-500"}>
            {log}
          </div>
        ))}
      </div>
    </div>
  );
}
