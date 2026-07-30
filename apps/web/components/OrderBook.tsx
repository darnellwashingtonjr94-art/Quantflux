"use client";

import React, { useState, useEffect } from "react";

interface OrderBookProps {
  symbol: string;
}

export default function OrderBook({ symbol }: OrderBookProps) {
  const [bids, setBids] = useState<{ price: number; size: number }[]>([]);
  const [asks, setAsks] = useState<{ price: number; size: number }[]>([]);

  useEffect(() => {
    const interval = setInterval(() => {
      const basePrice = 142.50;
      const newAsks = Array.from({ length: 6 }, (_, i) => ({
        price: Number((basePrice + (i + 1) * 0.05).toFixed(2)),
        size: Number((Math.random() * 5 + 0.5).toFixed(2))
      })).reverse();

      const newBids = Array.from({ length: 6 }, (_, i) => ({
        price: Number((basePrice - (i + 1) * 0.05).toFixed(2)),
        size: Number((Math.random() * 5 + 0.5).toFixed(2))
      }));

      setAsks(newAsks);
      setBids(newBids);
    }, 800);

    return () => clearInterval(interval);
  }, []);

  return (
    <div className="bg-slate-900 border border-slate-800 rounded-lg p-4 flex flex-col h-full font-mono text-xs">
      <div className="flex justify-between items-center pb-2 border-b border-slate-800">
        <span className="font-bold text-slate-200">{symbol}</span>
        <span className="text-slate-500 text-[10px]">L2 MEMPOOL DEPTH</span>
      </div>

      <div className="flex flex-col justify-between flex-1 mt-3">
        {/* Asks (Sells) */}
        <div className="flex flex-col gap-1">
          {asks.map((ask, idx) => (
            <div key={idx} className="flex justify-between text-rose-400 relative">
              <span>{ask.price.toFixed(2)}</span>
              <span className="text-slate-400">{ask.size.toFixed(2)}</span>
            </div>
          ))}
        </div>

        {/* Spread indicator */}
        <div className="py-2 my-1 border-y border-slate-800 text-center font-bold text-slate-100 bg-slate-950">
          SPREAD 0.10 MON
        </div>

        {/* Bids (Buys) */}
        <div className="flex flex-col gap-1">
          {bids.map((bid, idx) => (
            <div key={idx} className="flex justify-between text-emerald-400 relative">
              <span>{bid.price.toFixed(2)}</span>
              <span className="text-slate-400">{bid.size.toFixed(2)}</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
