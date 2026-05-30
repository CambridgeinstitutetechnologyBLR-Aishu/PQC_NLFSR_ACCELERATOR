import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

@cocotb.test()
async def test_nlfsr(dut):
    dut._log.info("Starting PQC NLFSR Gate-Level Test")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.rst_n.value = 0
    await RisingEdge(dut.clk)
    dut.rst_n.value = 1
    dut.ena.value = 1

    # Test shifting
    dut.ui_in.value = 0xAB
    dut.uio_in.value = 0x01 # Load seed
    await RisingEdge(dut.clk)
    
    dut.uio_in.value = 0x02 # Run
    await RisingEdge(dut.clk)
    
    # Gate level signals can be slow, wait a bit
    await RisingEdge(dut.clk)
    assert dut.uo_out.value != 0x00
    dut._log.info("Gate-Level Simulation Passed!")
