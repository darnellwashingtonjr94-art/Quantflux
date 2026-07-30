"use client";

import React, { useState, useEffect } from "react";
import TradingTerminal from "@/components/TradingTerminal";
import OrderBook from "@/components/OrderBook";
import SystemMetrics from "@/components/SystemMetrics";
import { Activity, ShieldCheck, Cpu, Zap } from "lucide-react";

export default function QuantfluxDashboard() {
  const [engineStatus, setEngineStatus] = useState<string>("SYNCING");
  const [latency, setLatency] = useState<number>(1.2);

  useEffect(() => {
    const timer = setInterval(() => {
      setLatency(Number((Math.random() * 0.8 + 0.8).toFixed(2)));
      setEngineStatus("ONLINE");
    }, 2000);
    return () => clearInterval(timer);
  }, []);

  return (
    <main className="min-h-screen bg-slate-950 text-slate-100 p-6 flex flex-col gap-6 font-mono">
      {/* Top Bar */}
      <header className="flex justify-between items-center border-b border-slate-800 pb-4">
        <div className="flex items-center gap-3">
          <Zap className="w-6 h-6 text-emerald-400 animate-pulse" />
          <h1 className="text-xl font-bold tracking-wider text-slate-50">QUANTFLUX // OS</h1>
        </div>
        <div className="flex gap-6 text-xs">
          <div className="flex items-center gap-2 bg-slate-900 px-3 py-1.5 rounded border border-slate-800">
            <Cpu className="w-4 h-4 text-cyan-400" />
            <span>EXECUTION: <span className="text-emerald-400 font-bold">{engineStatus}</span></span>
          </div>
          <div className="flex items-center gap-2 bg-slate-900 px-3 py-1.5 rounded border border-slate-800">
            <Activity className="w-4 h-4 text-amber-400" />
            <span>RPC LATENCY: <span className="text-slate-200">{latency} ms</span></span>
          </div>
        </div>
      </header>

      {/* Main Grid Workspace */}
      <div className="grid grid-cols-12 gap-6 flex-1">
        <div className="col-span-8 flex flex-col gap-6">
          <TradingTerminal />
          <SystemMetrics />
        </div>
        <div className="col-span-4">
          <OrderBook symbol="MONAD-PERP" />
        </div>
      </div>
    </main>
  );
}
