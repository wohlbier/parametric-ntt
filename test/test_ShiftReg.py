import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
#import random

async def reset(dut):
    dut.reset <= 1

    await ClockCycles(dut.clk, 2)
    dut.reset <= 0;

@cocotb.test()
async def test_ShiftReg(dut):
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.fork(clock.start())

    await reset(dut)

    for i in range(0,4):
        dut.data_in = 1
        await ClockCycles(dut.clk, 1)
        dut.data_in = 0
        await ClockCycles(dut.clk, 1)

    await ClockCycles(dut.clk, 8)
