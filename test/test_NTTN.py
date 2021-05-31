import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
#import random

#async def reset(dut):
#    dut.reset <= 1
#
#    await ClockCycles(dut.clk, 5)
#    dut.reset <= 0;

@cocotb.test()
async def test_NTTN(dut):
    print("hello")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())

#    dut.a <= 20
#    dut.b <= 30
#    dut.c <= 2147483647
#    dut.d <= 2147483647

    await ClockCycles(dut.clk, 5)
#    
#    # assert answer
#    assert(dut.z == 9223372163556310989)
