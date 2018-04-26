-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: ControlUnit.vhd
-- date: 4/4/2017

-- Unidade que controla os componentes da CPU

library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
    port(
		instruction                 : in STD_LOGIC_VECTOR(15 downto 0);  -- instrução para executar
		zr,ng                       : in STD_LOGIC;                      -- valores zr(se zero) e ng(se negativo) da ALU
		muxALUI_A                   : out STD_LOGIC;                     -- mux que seleciona entre instrução e ALU para reg. A
		muxAM_ALU                   : out STD_LOGIC;                     -- mux que seleciona entre reg. A e Mem. RAM para ALU
		muxSD_ALU                   : out STD_LOGIC;                     -- mux que seleciona entre reg. S e reg. D
		zx, nx, zy, ny, f, no       : out STD_LOGIC;                     -- sinais de controle da ALU
		loadA, loadD, loadS, loadM, loadPC : out STD_LOGIC               -- sinais de load do reg. A, reg. D,
                                                                     -- Mem. RAM e Program Counter
    );
end entity;

architecture arch of ControlUnit is
begin
-- MUX
	muxALUI_A <= not instruction(15);
    muxAM_ALU <= instruction(14);
    muxSD_ALU <= instruction(13);
-- ALU
    zx <= instruction(12);
    nx <= instruction(11);
    zy <= instruction(10);
    ny <= instruction(9);
    f  <= instruction(8);
    no <= instruction(7);
-- LOADS
    loadA <= '1' when muxALUI_A else
        instruction(6);
    loadD <= '0' when muxALUI_A else
        instruction(4);
    loadS <= '0' when muxALUI_A else
        instruction(5);
    loadM <= '0' when muxALUI_A else
        instruction(3);
    loadPC <= '0' when muxALUI_A else
        '1' when instruction(1) and zr else
        '1' when instruction(2) and ng else
        '1' when instruction(0) and not ng and not zr else
        '0';
end architecture;
