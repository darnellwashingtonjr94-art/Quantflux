import os
import asyncio
from fastapi import FastAPI, HTTPException, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional

app = FastAPI(
    title="Quantflux API Gateway",
    version="1.0.0",
    description="High-frequency API gateway for market routing, risk evaluation, and system telemetries."
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class OrderRequest(BaseModel):
    symbol: str
    side: str  # "buy" or "sell"
    amount: float
    price: Optional[float] = None
    order_type: str = "limit"
    venue: str = "monad"

class OrderResponse(BaseModel):
    order_id: str
    status: str
    executed_qty: float
    symbol: str

@app.get("/health")
async def health_check():
    return {"status": "ok", "engine": "online", "version": "1.0.0"}

@app.post("/api/v1/orders", response_model=OrderResponse)
async def submit_order(order: OrderRequest):
    if order.amount <= 0:
        raise HTTPException(status_code=400, detail="Order amount must be greater than zero.")
    
    # Stub for passing order to trading-engine execution queue via Redis/Kafka
    order_id = f"ord_{os.urandom(4).hex()}"
    return OrderResponse(
        order_id=order_id,
        status="submitted",
        executed_qty=0.0,
        symbol=order.symbol
    )

@app.websocket("/ws/market-data/{symbol}")
async def websocket_market_data(websocket: WebSocket, symbol: str):
    await websocket.accept()
    try:
        while True:
            # Simulate real-time streaming market tick data
            await websocket.send_json({
                "symbol": symbol.upper(),
                "bid": 100.25,
                "ask": 100.28,
                "timestamp": asyncio.get_event_loop().time()
            })
            await asyncio.sleep(0.1)
    except WebSocketDisconnect:
        print(f"Client disconnected from stream: {symbol}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
