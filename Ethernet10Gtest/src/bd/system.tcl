
################################################################
# This is a generated script based on design: system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2024.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   common::send_gid_msg -ssname BD::TCL -id 2040 -severity "CRITICAL WARNING" "This script was generated using Vivado <$scripts_vivado_version> without IP versions in the create_bd_cell commands, but is now being run in <$current_vivado_version> of Vivado. There may have been changes to the IP between Vivado <$scripts_vivado_version> and <$current_vivado_version>, which could impact the functionality and configuration of the design."

}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# eth_mac_10g_fifo_core, eth_mac_10g_fifo_core

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7k325tffv676-2
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:xlconstant:*\
xilinx.com:ip:clk_wiz:*\
xilinx.com:ip:proc_sys_reset:*\
xilinx.com:ip:system_ila:*\
xilinx.com:ip:ten_gig_eth_pcs_pma:*\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
eth_mac_10g_fifo_core\
eth_mac_10g_fifo_core\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set xcvr_refclk_156 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 xcvr_refclk_156 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $xcvr_refclk_156


  # Create ports
  set clk100 [ create_bd_port -dir I -type clk clk100 ]
  set configuration_vector_0 [ create_bd_port -dir I -from 535 -to 0 configuration_vector_0 ]
  set configuration_vector_1 [ create_bd_port -dir I -from 535 -to 0 configuration_vector_1 ]
  set resetn [ create_bd_port -dir I -type rst resetn ]
  set rxn_0 [ create_bd_port -dir I rxn_0 ]
  set rxn_1 [ create_bd_port -dir I rxn_1 ]
  set rxp_0 [ create_bd_port -dir I rxp_0 ]
  set rxp_1 [ create_bd_port -dir I rxp_1 ]
  set txn_0 [ create_bd_port -dir O txn_0 ]
  set txn_1 [ create_bd_port -dir O txn_1 ]
  set txp_0 [ create_bd_port -dir O txp_0 ]
  set txp_1 [ create_bd_port -dir O txp_1 ]

  # Create instance: ONE, and set properties
  set ONE [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant ONE ]
  set_property CONFIG.CONST_VAL {1} $ONE


  # Create instance: ZERO, and set properties
  set ZERO [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant ZERO ]
  set_property CONFIG.CONST_VAL {0} $ZERO


  # Create instance: clk_wiz, and set properties
  set clk_wiz [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz clk_wiz ]
  set_property -dict [list \
    CONFIG.RESET_PORT {resetn} \
    CONFIG.RESET_TYPE {ACTIVE_LOW} \
  ] $clk_wiz


  # Create instance: eth_mac_10g_fifo_core_0, and set properties
  set block_name eth_mac_10g_fifo_core
  set block_cell_name eth_mac_10g_fifo_core_0
  if { [catch {set eth_mac_10g_fifo_core_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $eth_mac_10g_fifo_core_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: eth_mac_10g_fifo_core_1, and set properties
  set block_name eth_mac_10g_fifo_core
  set block_cell_name eth_mac_10g_fifo_core_1
  if { [catch {set eth_mac_10g_fifo_core_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $eth_mac_10g_fifo_core_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset proc_sys_reset_0 ]

  # Create instance: proc_sys_reset_1, and set properties
  set proc_sys_reset_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset proc_sys_reset_1 ]

  # Create instance: system_ila_0, and set properties
  set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila system_ila_0 ]
  set_property -dict [list \
    CONFIG.C_DATA_DEPTH {16384} \
    CONFIG.C_MON_TYPE {MIX} \
    CONFIG.C_NUM_MONITOR_SLOTS {2} \
    CONFIG.C_NUM_OF_PROBES {2} \
    CONFIG.C_PROBE0_WIDTH {8} \
    CONFIG.C_PROBE1_WIDTH {8} \
    CONFIG.C_PROBE3_WIDTH {1} \
    CONFIG.C_PROBE_WIDTH_PROPAGATION {MANUAL} \
    CONFIG.C_SLOT {1} \
    CONFIG.C_SLOT_0_AXIS_TDATA_WIDTH {64} \
    CONFIG.C_SLOT_0_AXIS_TDEST_WIDTH {1} \
    CONFIG.C_SLOT_0_AXIS_TID_WIDTH {0} \
    CONFIG.C_SLOT_0_AXIS_TUSER_WIDTH {1} \
    CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
    CONFIG.C_SLOT_1_AXIS_TDATA_WIDTH {64} \
    CONFIG.C_SLOT_1_AXIS_TDEST_WIDTH {1} \
    CONFIG.C_SLOT_1_AXIS_TID_WIDTH {0} \
    CONFIG.C_SLOT_1_AXIS_TUSER_WIDTH {1} \
    CONFIG.C_SLOT_1_AXI_ADDR_WIDTH {AUTO} \
    CONFIG.C_SLOT_1_AXI_DATA_WIDTH {64} \
    CONFIG.C_SLOT_1_AXI_ID_WIDTH {AUTO} \
    CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
  ] $system_ila_0


  # Create instance: ten_gig_eth_pcs_pma_0, and set properties
  set ten_gig_eth_pcs_pma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ten_gig_eth_pcs_pma ten_gig_eth_pcs_pma_0 ]
  set_property -dict [list \
    CONFIG.MDIO_Management {false} \
    CONFIG.SupportLevel {1} \
  ] $ten_gig_eth_pcs_pma_0


  # Create instance: ten_gig_eth_pcs_pma_1, and set properties
  set ten_gig_eth_pcs_pma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ten_gig_eth_pcs_pma ten_gig_eth_pcs_pma_1 ]
  set_property CONFIG.MDIO_Management {false} $ten_gig_eth_pcs_pma_1


  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant xlconstant_2 ]
  set_property -dict [list \
    CONFIG.CONST_VAL {5} \
    CONFIG.CONST_WIDTH {3} \
  ] $xlconstant_2


  # Create interface connections
  connect_bd_intf_net -intf_net eth_mac_10g_fifo_core_0_rx_axis [get_bd_intf_pins eth_mac_10g_fifo_core_1/rx_axis] [get_bd_intf_pins eth_mac_10g_fifo_core_0/tx_axis]
connect_bd_intf_net -intf_net [get_bd_intf_nets eth_mac_10g_fifo_core_0_rx_axis] [get_bd_intf_pins eth_mac_10g_fifo_core_1/rx_axis] [get_bd_intf_pins system_ila_0/SLOT_1_AXIS]
  connect_bd_intf_net -intf_net eth_mac_10g_fifo_core_0_rx_axis1 [get_bd_intf_pins eth_mac_10g_fifo_core_0/rx_axis] [get_bd_intf_pins eth_mac_10g_fifo_core_1/tx_axis]
connect_bd_intf_net -intf_net [get_bd_intf_nets eth_mac_10g_fifo_core_0_rx_axis1] [get_bd_intf_pins eth_mac_10g_fifo_core_0/rx_axis] [get_bd_intf_pins system_ila_0/SLOT_0_AXIS]
  connect_bd_intf_net -intf_net eth_mac_10g_fifo_core_0_xgmii [get_bd_intf_pins eth_mac_10g_fifo_core_1/xgmii] [get_bd_intf_pins ten_gig_eth_pcs_pma_1/xgmii_interface]
  connect_bd_intf_net -intf_net eth_mac_10g_fifo_core_0_xgmii1 [get_bd_intf_pins eth_mac_10g_fifo_core_0/xgmii] [get_bd_intf_pins ten_gig_eth_pcs_pma_0/xgmii_interface]
  connect_bd_intf_net -intf_net refclk_diff_port_0_1 [get_bd_intf_ports xcvr_refclk_156] [get_bd_intf_pins ten_gig_eth_pcs_pma_0/refclk_diff_port]
  connect_bd_intf_net -intf_net ten_gig_eth_pcs_pma_0_core_gt_drp_interface [get_bd_intf_pins ten_gig_eth_pcs_pma_0/core_gt_drp_interface] [get_bd_intf_pins ten_gig_eth_pcs_pma_0/user_gt_drp_interface]
  connect_bd_intf_net -intf_net ten_gig_eth_pcs_pma_1_core_gt_drp_interface [get_bd_intf_pins ten_gig_eth_pcs_pma_1/core_gt_drp_interface] [get_bd_intf_pins ten_gig_eth_pcs_pma_1/user_gt_drp_interface]

  # Create port connections
  connect_bd_net -net ONE_dout  [get_bd_pins ONE/dout] \
  [get_bd_pins ten_gig_eth_pcs_pma_0/signal_detect] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/signal_detect]
  connect_bd_net -net ZERO_dout  [get_bd_pins ZERO/dout] \
  [get_bd_pins ten_gig_eth_pcs_pma_0/sim_speedup_control] \
  [get_bd_pins ten_gig_eth_pcs_pma_0/tx_fault] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/tx_fault]
  connect_bd_net -net clk_in1_0_1  [get_bd_ports clk100] \
  [get_bd_pins clk_wiz/clk_in1]
  connect_bd_net -net clk_wiz_clk_out1  [get_bd_pins clk_wiz/clk_out1] \
  [get_bd_pins proc_sys_reset_0/slowest_sync_clk] \
  [get_bd_pins ten_gig_eth_pcs_pma_0/dclk] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/dclk]
  connect_bd_net -net clk_wiz_locked  [get_bd_pins clk_wiz/locked] \
  [get_bd_pins proc_sys_reset_0/dcm_locked]
  connect_bd_net -net configuration_vector_0_1  [get_bd_ports configuration_vector_0] \
  [get_bd_pins ten_gig_eth_pcs_pma_0/configuration_vector]
  connect_bd_net -net configuration_vector_1_1  [get_bd_ports configuration_vector_1] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/configuration_vector]
  connect_bd_net -net proc_sys_reset_0_peripheral_reset  [get_bd_pins proc_sys_reset_0/peripheral_reset] \
  [get_bd_pins ten_gig_eth_pcs_pma_0/reset]
  connect_bd_net -net proc_sys_reset_1_peripheral_aresetn  [get_bd_pins proc_sys_reset_1/peripheral_aresetn] \
  [get_bd_pins system_ila_0/resetn]
  connect_bd_net -net proc_sys_reset_1_peripheral_reset  [get_bd_pins proc_sys_reset_1/peripheral_reset] \
  [get_bd_pins eth_mac_10g_fifo_core_0/logic_rst] \
  [get_bd_pins eth_mac_10g_fifo_core_0/rx_rst] \
  [get_bd_pins eth_mac_10g_fifo_core_0/tx_rst] \
  [get_bd_pins eth_mac_10g_fifo_core_1/logic_rst] \
  [get_bd_pins eth_mac_10g_fifo_core_1/rx_rst] \
  [get_bd_pins eth_mac_10g_fifo_core_1/tx_rst]
  connect_bd_net -net resetn_0_1  [get_bd_ports resetn] \
  [get_bd_pins clk_wiz/resetn] \
  [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net rxn_0_1  [get_bd_ports rxn_0] \
  [get_bd_pins ten_gig_eth_pcs_pma_0/rxn]
  connect_bd_net -net rxn_1_1  [get_bd_ports rxn_1] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/rxn]
  connect_bd_net -net rxp_0_1  [get_bd_ports rxp_0] \
  [get_bd_pins ten_gig_eth_pcs_pma_0/rxp]
  connect_bd_net -net rxp_1_1  [get_bd_ports rxp_1] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/rxp]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_areset_datapathclk_out  [get_bd_pins ten_gig_eth_pcs_pma_0/areset_datapathclk_out] \
  [get_bd_pins proc_sys_reset_1/ext_reset_in] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/areset] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/areset_coreclk]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_core_status  [get_bd_pins ten_gig_eth_pcs_pma_0/core_status] \
  [get_bd_pins system_ila_0/probe0]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_coreclk_out  [get_bd_pins ten_gig_eth_pcs_pma_0/coreclk_out] \
  [get_bd_pins eth_mac_10g_fifo_core_0/logic_clk] \
  [get_bd_pins eth_mac_10g_fifo_core_0/xgmii_clk] \
  [get_bd_pins eth_mac_10g_fifo_core_1/logic_clk] \
  [get_bd_pins eth_mac_10g_fifo_core_1/xgmii_clk] \
  [get_bd_pins proc_sys_reset_1/slowest_sync_clk] \
  [get_bd_pins system_ila_0/clk] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/coreclk]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_drp_req  [get_bd_pins ten_gig_eth_pcs_pma_0/drp_req] \
  [get_bd_pins ten_gig_eth_pcs_pma_0/drp_gnt]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_gtrxreset_out  [get_bd_pins ten_gig_eth_pcs_pma_0/gtrxreset_out] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/gtrxreset]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_gttxreset_out  [get_bd_pins ten_gig_eth_pcs_pma_0/gttxreset_out] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/gttxreset]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_qplllock_out  [get_bd_pins ten_gig_eth_pcs_pma_0/qplllock_out] \
  [get_bd_pins proc_sys_reset_1/dcm_locked] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/qplllock]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_qplloutclk_out  [get_bd_pins ten_gig_eth_pcs_pma_0/qplloutclk_out] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/qplloutclk]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_qplloutrefclk_out  [get_bd_pins ten_gig_eth_pcs_pma_0/qplloutrefclk_out] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/qplloutrefclk]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_reset_counter_done_out  [get_bd_pins ten_gig_eth_pcs_pma_0/reset_counter_done_out] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/reset_counter_done]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_txn  [get_bd_pins ten_gig_eth_pcs_pma_0/txn] \
  [get_bd_ports txn_0]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_txp  [get_bd_pins ten_gig_eth_pcs_pma_0/txp] \
  [get_bd_ports txp_0]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_txuserrdy_out  [get_bd_pins ten_gig_eth_pcs_pma_0/txuserrdy_out] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/txuserrdy]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_txusrclk2_out  [get_bd_pins ten_gig_eth_pcs_pma_0/txusrclk2_out] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/txusrclk2]
  connect_bd_net -net ten_gig_eth_pcs_pma_0_txusrclk_out  [get_bd_pins ten_gig_eth_pcs_pma_0/txusrclk_out] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/txusrclk]
  connect_bd_net -net ten_gig_eth_pcs_pma_1_core_status  [get_bd_pins ten_gig_eth_pcs_pma_1/core_status] \
  [get_bd_pins system_ila_0/probe1]
  connect_bd_net -net ten_gig_eth_pcs_pma_1_drp_req  [get_bd_pins ten_gig_eth_pcs_pma_1/drp_req] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/drp_gnt]
  connect_bd_net -net ten_gig_eth_pcs_pma_1_txn  [get_bd_pins ten_gig_eth_pcs_pma_1/txn] \
  [get_bd_ports txn_1]
  connect_bd_net -net ten_gig_eth_pcs_pma_1_txp  [get_bd_pins ten_gig_eth_pcs_pma_1/txp] \
  [get_bd_ports txp_1]
  connect_bd_net -net xlconstant_2_dout  [get_bd_pins xlconstant_2/dout] \
  [get_bd_pins ten_gig_eth_pcs_pma_0/pma_pmd_type] \
  [get_bd_pins ten_gig_eth_pcs_pma_1/pma_pmd_type]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


