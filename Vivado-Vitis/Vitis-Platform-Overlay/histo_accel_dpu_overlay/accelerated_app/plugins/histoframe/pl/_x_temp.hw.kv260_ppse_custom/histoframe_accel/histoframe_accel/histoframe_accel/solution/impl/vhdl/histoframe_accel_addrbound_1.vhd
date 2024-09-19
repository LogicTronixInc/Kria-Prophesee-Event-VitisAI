-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity histoframe_accel_addrbound_1 is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    start_full_n : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    start_out : OUT STD_LOGIC;
    start_write : OUT STD_LOGIC;
    return_r : OUT STD_LOGIC_VECTOR (17 downto 0);
    rows : IN STD_LOGIC_VECTOR (31 downto 0);
    cols : IN STD_LOGIC_VECTOR (31 downto 0);
    rows_c_din : OUT STD_LOGIC_VECTOR (31 downto 0);
    rows_c_num_data_valid : IN STD_LOGIC_VECTOR (2 downto 0);
    rows_c_fifo_cap : IN STD_LOGIC_VECTOR (2 downto 0);
    rows_c_full_n : IN STD_LOGIC;
    rows_c_write : OUT STD_LOGIC;
    cols_c_din : OUT STD_LOGIC_VECTOR (31 downto 0);
    cols_c_num_data_valid : IN STD_LOGIC_VECTOR (2 downto 0);
    cols_c_fifo_cap : IN STD_LOGIC_VECTOR (2 downto 0);
    cols_c_full_n : IN STD_LOGIC;
    cols_c_write : OUT STD_LOGIC );
end;


architecture behav of histoframe_accel_addrbound_1 is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (4 downto 0) := "00010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (4 downto 0) := "00100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (4 downto 0) := "01000";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (4 downto 0) := "10000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv18_0 : STD_LOGIC_VECTOR (17 downto 0) := "000000000000000000";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv25_7F : STD_LOGIC_VECTOR (24 downto 0) := "0000000000000000001111111";
    constant ap_const_lv32_7 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000111";
    constant ap_const_lv32_18 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000011000";

attribute shreg_extract : string;
    signal real_start : STD_LOGIC;
    signal start_once_reg : STD_LOGIC := '0';
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal internal_ap_ready : STD_LOGIC;
    signal rows_c_blk_n : STD_LOGIC;
    signal cols_c_blk_n : STD_LOGIC;
    signal trunc_ln_reg_135 : STD_LOGIC_VECTOR (17 downto 0);
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal ap_block_state1 : BOOLEAN;
    signal return_r_preg : STD_LOGIC_VECTOR (17 downto 0) := "000000000000000000";
    signal ap_CS_fsm_state5 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state5 : signal is "none";
    signal lhs_fu_79_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal rhs_fu_83_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal ret_V_fu_95_p1 : STD_LOGIC_VECTOR (21 downto 0);
    signal grp_fu_118_p2 : STD_LOGIC_VECTOR (21 downto 0);
    signal ret_V_fu_95_p3 : STD_LOGIC_VECTOR (24 downto 0);
    signal add_ln541_fu_102_p2 : STD_LOGIC_VECTOR (24 downto 0);
    signal grp_fu_118_p0 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_fu_118_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_fu_118_ce : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ST_fsm_state4_blk : STD_LOGIC;
    signal ap_ST_fsm_state5_blk : STD_LOGIC;
    signal grp_fu_118_p00 : STD_LOGIC_VECTOR (21 downto 0);
    signal grp_fu_118_p10 : STD_LOGIC_VECTOR (21 downto 0);
    signal ap_ce_reg : STD_LOGIC;

    component histoframe_accel_mul_mul_16ns_16ns_22_4_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (15 downto 0);
        din1 : IN STD_LOGIC_VECTOR (15 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (21 downto 0) );
    end component;



begin
    mul_mul_16ns_16ns_22_4_1_U7 : component histoframe_accel_mul_mul_16ns_16ns_22_4_1
    generic map (
        ID => 1,
        NUM_STAGE => 4,
        din0_WIDTH => 16,
        din1_WIDTH => 16,
        dout_WIDTH => 22)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_118_p0,
        din1 => grp_fu_118_p1,
        ce => grp_fu_118_ce,
        dout => grp_fu_118_p2);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_done_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_done_reg <= ap_const_logic_0;
            else
                if ((ap_continue = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    return_r_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                return_r_preg <= ap_const_lv18_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
                    return_r_preg <= trunc_ln_reg_135;
                end if; 
            end if;
        end if;
    end process;


    start_once_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                start_once_reg <= ap_const_logic_0;
            else
                if (((internal_ap_ready = ap_const_logic_0) and (real_start = ap_const_logic_1))) then 
                    start_once_reg <= ap_const_logic_1;
                elsif ((internal_ap_ready = ap_const_logic_1)) then 
                    start_once_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state4)) then
                trunc_ln_reg_135 <= add_ln541_fu_102_p2(24 downto 7);
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (real_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, rows_c_full_n, cols_c_full_n)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (real_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_state3;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state4;
            when ap_ST_fsm_state4 => 
                ap_NS_fsm <= ap_ST_fsm_state5;
            when ap_ST_fsm_state5 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXXXX";
        end case;
    end process;
    add_ln541_fu_102_p2 <= std_logic_vector(unsigned(ret_V_fu_95_p3) + unsigned(ap_const_lv25_7F));
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);
    ap_CS_fsm_state5 <= ap_CS_fsm(4);

    ap_ST_fsm_state1_blk_assign_proc : process(real_start, ap_done_reg, rows_c_full_n, cols_c_full_n)
    begin
        if (((cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (real_start = ap_const_logic_0))) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state2_blk <= ap_const_logic_0;
    ap_ST_fsm_state3_blk <= ap_const_logic_0;
    ap_ST_fsm_state4_blk <= ap_const_logic_0;
    ap_ST_fsm_state5_blk <= ap_const_logic_0;

    ap_block_state1_assign_proc : process(real_start, ap_done_reg, rows_c_full_n, cols_c_full_n)
    begin
                ap_block_state1 <= ((cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (real_start = ap_const_logic_0));
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_CS_fsm_state5)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(real_start, ap_CS_fsm_state1)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and (real_start = ap_const_logic_0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;

    ap_ready <= internal_ap_ready;

    cols_c_blk_n_assign_proc : process(real_start, ap_done_reg, ap_CS_fsm_state1, cols_c_full_n)
    begin
        if ((not(((ap_done_reg = ap_const_logic_1) or (real_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            cols_c_blk_n <= cols_c_full_n;
        else 
            cols_c_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    cols_c_din <= cols;

    cols_c_write_assign_proc : process(real_start, ap_done_reg, ap_CS_fsm_state1, rows_c_full_n, cols_c_full_n)
    begin
        if ((not(((cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (real_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            cols_c_write <= ap_const_logic_1;
        else 
            cols_c_write <= ap_const_logic_0;
        end if; 
    end process;


    grp_fu_118_ce_assign_proc : process(real_start, ap_done_reg, ap_CS_fsm_state1, rows_c_full_n, cols_c_full_n, ap_CS_fsm_state5)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state5) or ((ap_const_logic_1 = ap_CS_fsm_state1) and ((cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (real_start = ap_const_logic_0))))) then 
            grp_fu_118_ce <= ap_const_logic_0;
        else 
            grp_fu_118_ce <= ap_const_logic_1;
        end if; 
    end process;

    grp_fu_118_p0 <= grp_fu_118_p00(16 - 1 downto 0);
    grp_fu_118_p00 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(rhs_fu_83_p1),22));
    grp_fu_118_p1 <= grp_fu_118_p10(16 - 1 downto 0);
    grp_fu_118_p10 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(lhs_fu_79_p1),22));

    internal_ap_ready_assign_proc : process(ap_CS_fsm_state5)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
            internal_ap_ready <= ap_const_logic_1;
        else 
            internal_ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    lhs_fu_79_p1 <= rows(16 - 1 downto 0);

    real_start_assign_proc : process(ap_start, start_full_n, start_once_reg)
    begin
        if (((start_once_reg = ap_const_logic_0) and (start_full_n = ap_const_logic_0))) then 
            real_start <= ap_const_logic_0;
        else 
            real_start <= ap_start;
        end if; 
    end process;

    ret_V_fu_95_p1 <= grp_fu_118_p2;
    ret_V_fu_95_p3 <= (ret_V_fu_95_p1 & ap_const_lv3_0);

    return_r_assign_proc : process(trunc_ln_reg_135, return_r_preg, ap_CS_fsm_state5)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
            return_r <= trunc_ln_reg_135;
        else 
            return_r <= return_r_preg;
        end if; 
    end process;

    rhs_fu_83_p1 <= cols(16 - 1 downto 0);

    rows_c_blk_n_assign_proc : process(real_start, ap_done_reg, ap_CS_fsm_state1, rows_c_full_n)
    begin
        if ((not(((ap_done_reg = ap_const_logic_1) or (real_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            rows_c_blk_n <= rows_c_full_n;
        else 
            rows_c_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    rows_c_din <= rows;

    rows_c_write_assign_proc : process(real_start, ap_done_reg, ap_CS_fsm_state1, rows_c_full_n, cols_c_full_n)
    begin
        if ((not(((cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (real_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            rows_c_write <= ap_const_logic_1;
        else 
            rows_c_write <= ap_const_logic_0;
        end if; 
    end process;

    start_out <= real_start;

    start_write_assign_proc : process(real_start, start_once_reg)
    begin
        if (((start_once_reg = ap_const_logic_0) and (real_start = ap_const_logic_1))) then 
            start_write <= ap_const_logic_1;
        else 
            start_write <= ap_const_logic_0;
        end if; 
    end process;

end behav;