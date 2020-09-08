BIF_PARTITION_ATTR_zynqmp = "${@'fsbl pmu atf u-boot' if d.getVar('FPGA_MNGR_RECONFIG_ENABLE') == '1' else 'fsbl bitstream pmu atf dtb u-boot'}"
