# Test Mode 0 (Standard)
    dut.uio_in.value = 0x01 # Load
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0x02 # Run Mode 0
    await RisingEdge(dut.clk)
    val0 = dut.uo_out.value

    # Test Mode 1 (Chaotic Innovation)
    dut.uio_in.value = 0x01 # Load
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0x06 # Run Mode 1 (Bit 2 is high)
    await RisingEdge(dut.clk)
    val1 = dut.uo_out.value

    assert val0 != val1 # If they are different, your innovation works!
