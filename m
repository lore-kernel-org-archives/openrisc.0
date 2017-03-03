From: Stafford Horne <shorne@gmail.com>
Date: Fri, 3 Mar 2017 13:08:03 +0900
Subject: [OpenRISC] gcc7 port and improvements
In-Reply-To: <4bfff4c5-fdea-563b-3b84-340b1bc6b708@twiddle.net>
References: <93ad6594-b3f1-5a4f-14d4-f45cb72229f5@twiddle.net>
 <4bfff4c5-fdea-563b-3b84-340b1bc6b708@twiddle.net>
Message-ID: <20170303040803.GZ2449@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Mar 03, 2017 at 09:14:17AM +1100, Richard Henderson wrote:
> On 02/23/2017 12:01 PM, Richard Henderson wrote:
> > If this goes well, I have some additional patches to revive that enhance both
> > binutils and gcc with additional relocations so that the low-part of an address
> > can be moved into a load or store offset.
> 
> Please see
> 
>   git://github.com/rth7680/binutils-gdb.git or1k-3
>   git://github.com/rth7680/gcc.git or1k-7-1

It looks like you rebased this on my binutils-gdb or1k-upstream branch.
Sorry, but I often blow that away with rebase.  I didnt realize other
would be pulling from there :)

I hope it doesnt cause any issues, I am currently working on
restructuring the or1k sim there as per the comments from Mike
Frysinger, so there is a bit of garbage right now.

Also, I see you have fixed up the 64-bit target as well.  Does anyone
use openrisc 64-bit?  I remember hearing there is no soft core.  I ask
because I was considering removing the 64bit gdb/sim code since as far
as I can see its not complete, and probably should be a separate sim on
its own as per the gdb/sim's go. Any issues let me know.

> which includes the additional relocations both for unmodified or1k, as well
> as implementing the l.adrp proposal from
> 
>   http://openrisc.io/proposals/ladrp
> 
> The new insn is not enabled by default, but by -madrp.  Patches to emulate
> this new instruction are at
> 
>   git://github.com/rth7680/qemu.git tgt-openrisc
>   git://github.com/rth7680/or1ksim.git adrp

Thanks, this is good.  We need to get this into the spec.  SPec updating
is something I plan to do soon (for SMP) a few things to add are:

  - Using r11? for TLS (defactor standard)
  - The l.lwa operation overlapping with an unaligned l.sh will cause an
    atomic break, but its not clearly documented in the spec.  (i.e.
    all bus addresses atomic and not are word aligned, and used to check
    the atomic reservation address)
  - The IPI interface for SMP
  - Shadow registers (it seems we implemented this a bit different from
    the spec?)

I guess if we do want to use these in the linux kernel adding emulation
to the linux kernel would be required.

> And, though I've really no idea how to go about either compiling or testing
> it, I've made an attempt at adding l.adrp to the mor1kx vhdl.  Monkey see,
> monkey do.  See below.
> 
> Comments?

As mentioned I am looking into gdb/sim updates right now for gdb
upstreaming.  I will look into testing these afterwards.

In terms of compiling the Verilog for mor1kx, this can be done with
fusesoc tool and verilor or Altera quartus or the Xilinx tool.

I think others on the list can assist.

Sorry for hi-jacking with a lot of my rambling here.  But this looks
good.

-Stafford

> r~

> diff --git a/rtl/verilog/mor1kx-defines.v b/rtl/verilog/mor1kx-defines.v
> index 365c8a6..795df6f 100644
> --- a/rtl/verilog/mor1kx-defines.v
> +++ b/rtl/verilog/mor1kx-defines.v
> @@ -79,6 +79,7 @@
>  
>  `define OR1K_OPCODE_J       {2'b00, 4'h0}
>  `define OR1K_OPCODE_JAL     {2'b00, 4'h1}
> +`define OR1K_OPCODE_ADRP    {2'b00, 4'h2}
>  `define OR1K_OPCODE_BNF     {2'b00, 4'h3}
>  `define OR1K_OPCODE_BF      {2'b00, 4'h4}
>  `define OR1K_OPCODE_NOP     {2'b00, 4'h5}
> diff --git a/rtl/verilog/mor1kx_cpu_cappuccino.v b/rtl/verilog/mor1kx_cpu_cappuccino.v
> index 2e9b309..b2fec24 100644
> --- a/rtl/verilog/mor1kx_cpu_cappuccino.v
> +++ b/rtl/verilog/mor1kx_cpu_cappuccino.v
> @@ -260,6 +260,7 @@ module mor1kx_cpu_cappuccino
>     wire                 decode_op_lsu_store_o;  // From mor1kx_decode of mor1kx_decode.v
>     wire                 decode_op_mfspr_o;      // From mor1kx_decode of mor1kx_decode.v
>     wire                 decode_op_movhi_o;      // From mor1kx_decode of mor1kx_decode.v
> +   wire                 decode_op_adrp_o;       // From mor1kx_decode of mor1kx_decode.v
>     wire                 decode_op_msync_o;      // From mor1kx_decode of mor1kx_decode.v
>     wire [`OR1K_FPUOP_WIDTH-1:0] decode_op_fpu_o; // From mor1kx_decode of mor1kx_decode.v
>     wire                 decode_op_mtspr_o;      // From mor1kx_decode of mor1kx_decode.v
> @@ -318,6 +319,7 @@ module mor1kx_cpu_cappuccino
>     wire                 execute_op_lsu_store_o; // From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
>     wire                 execute_op_mfspr_o;     // From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
>     wire                 execute_op_movhi_o;     // From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
> +   wire                 execute_op_adrp_o;      // From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
>     wire                 execute_op_msync_o;     // From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
>     wire [`OR1K_FPUOP_WIDTH-1:0] execute_op_fpu_o; // From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
>     wire                 execute_op_mtspr_o;     // From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
> @@ -545,6 +547,7 @@ module mor1kx_cpu_cappuccino
>        .decode_op_shift_o                (decode_op_shift_o),
>        .decode_op_ffl1_o                 (decode_op_ffl1_o),
>        .decode_op_movhi_o                (decode_op_movhi_o),
> +      .decode_op_adrp_o                 (decode_op_adrp_o),
>        .decode_op_msync_o                (decode_op_msync_o),
>        .decode_op_fpu_o                  (decode_op_fpu_o),
>        .decode_adder_do_sub_o            (decode_adder_do_sub_o),
> @@ -610,6 +613,7 @@ module mor1kx_cpu_cappuccino
>        .decode_op_shift_i		(decode_op_shift_o),
>        .decode_op_ffl1_i			(decode_op_ffl1_o),
>        .decode_op_movhi_i		(decode_op_movhi_o),
> +      .decode_op_adrp_i			(decode_op_adrp_o),
>        .decode_op_msync_i                (decode_op_msync_o),
>        .decode_op_fpu_i		  (decode_op_fpu_o),
>        .decode_opc_insn_i		(decode_opc_insn_o[`OR1K_OPCODE_WIDTH-1:0]),
> @@ -670,6 +674,7 @@ module mor1kx_cpu_cappuccino
>        .execute_op_shift_o               (execute_op_shift_o),
>        .execute_op_ffl1_o                (execute_op_ffl1_o),
>        .execute_op_movhi_o               (execute_op_movhi_o),
> +      .execute_op_adrp_o                (execute_op_adrp_o),
>        .execute_op_msync_o               (execute_op_msync_o),
>        .execute_op_fpu_o                 (execute_op_fpu_o),
>        .execute_op_bf_o                  (execute_op_bf_o),
> @@ -741,6 +746,7 @@ module mor1kx_cpu_cappuccino
>        .decode_op_shift_i                (decode_op_shift_o),     // Templated
>        .decode_op_ffl1_i                 (decode_op_ffl1_o),      // Templated
>        .decode_op_movhi_i                (decode_op_movhi_o),     // Templated
> +      .decode_op_adrp_i                 (decode_op_adrp_o),      // Templated
>        .decode_op_msync_i                (decode_op_msync_o),     // Templated
>        .decode_op_fpu_i                  (decode_op_fpu_o), // Templated
>        .decode_opc_insn_i                (decode_opc_insn_o[`OR1K_OPCODE_WIDTH-1:0]), // Templated
> @@ -814,6 +820,7 @@ module mor1kx_cpu_cappuccino
>      .op_mtspr_i				(execute_op_mtspr_o),
>      .op_mfspr_i				(execute_op_mfspr_o),
>      .op_movhi_i				(execute_op_movhi_o),
> +    .op_adrp_i				(execute_op_adrp_o),
>      .op_fpu_i				  (execute_op_fpu_o),
>      .fpu_round_mode_i (ctrl_fpu_round_mode_o),
>      .op_jbr_i				(execute_op_jbr_o),
> @@ -899,6 +906,7 @@ module mor1kx_cpu_cappuccino
>        .op_mtspr_i                       (execute_op_mtspr_o),    // Templated
>        .op_mfspr_i                       (execute_op_mfspr_o),    // Templated
>        .op_movhi_i                       (execute_op_movhi_o),    // Templated
> +      .op_adrp_i                        (execute_op_adrp_o),     // Templated
>        .op_fpu_i                         (execute_op_fpu_o), // Templated
>        .fpu_round_mode_i                 (ctrl_fpu_round_mode_o), // Templated
>        .op_jbr_i                         (execute_op_jbr_o),      // Templated
> diff --git a/rtl/verilog/mor1kx_cpu_espresso.v b/rtl/verilog/mor1kx_cpu_espresso.v
> index 3b40603..eac330c 100644
> --- a/rtl/verilog/mor1kx_cpu_espresso.v
> +++ b/rtl/verilog/mor1kx_cpu_espresso.v
> @@ -187,6 +187,7 @@ module mor1kx_cpu_espresso
>     wire			decode_op_lsu_store_o;	// From mor1kx_decode of mor1kx_decode.v
>     wire			decode_op_mfspr_o;	// From mor1kx_decode of mor1kx_decode.v
>     wire			decode_op_movhi_o;	// From mor1kx_decode of mor1kx_decode.v
> +   wire			decode_op_adrp_o;	// From mor1kx_decode of mor1kx_decode.v
>     wire			decode_op_mtspr_o;	// From mor1kx_decode of mor1kx_decode.v
>     wire			decode_op_mul_o;	// From mor1kx_decode of mor1kx_decode.v
>     wire			decode_op_mul_signed_o;	// From mor1kx_decode of mor1kx_decode.v
> @@ -358,6 +359,7 @@ module mor1kx_cpu_espresso
>        .decode_op_shift_o		(decode_op_shift_o),
>        .decode_op_ffl1_o			(decode_op_ffl1_o),
>        .decode_op_movhi_o		(decode_op_movhi_o),
> +      .decode_op_adrp_o			(decode_op_adrp_o),
>        .decode_adder_do_sub_o		(decode_adder_do_sub_o),
>        .decode_adder_do_carry_o		(decode_adder_do_carry_o),
>        .decode_except_illegal_o		(decode_except_illegal_o),
> @@ -392,6 +394,7 @@ module mor1kx_cpu_espresso
>      .op_mtspr_i				(decode_op_mtspr_o),
>      .op_mfspr_i				(decode_op_mfspr_o),
>      .op_movhi_i				(decode_op_movhi_o),
> +    .op_adrp_i				(decode_op_adrp_o),
>      .op_jbr_i				(decode_op_jbr_o),
>      .op_jr_i				(decode_op_jr_o),
>      .immjbr_upper_i			(decode_immjbr_upper_o),
> @@ -462,6 +465,7 @@ module mor1kx_cpu_espresso
>        .op_mtspr_i			(decode_op_mtspr_o),	 // Templated
>        .op_mfspr_i			(decode_op_mfspr_o),	 // Templated
>        .op_movhi_i			(decode_op_movhi_o),	 // Templated
> +      .op_adrp_i			(decode_op_adrp_o),	 // Templated
>        .op_jbr_i				(decode_op_jbr_o),	 // Templated
>        .op_jr_i				(decode_op_jr_o),	 // Templated
>        .immjbr_upper_i			(decode_immjbr_upper_o), // Templated
> diff --git a/rtl/verilog/mor1kx_cpu_prontoespresso.v b/rtl/verilog/mor1kx_cpu_prontoespresso.v
> index 61896cb..2b8f024 100644
> --- a/rtl/verilog/mor1kx_cpu_prontoespresso.v
> +++ b/rtl/verilog/mor1kx_cpu_prontoespresso.v
> @@ -191,6 +191,7 @@ module mor1kx_cpu_prontoespresso
>     wire			decode_op_lsu_store_o;	// From mor1kx_decode of mor1kx_decode.v
>     wire			decode_op_mfspr_o;	// From mor1kx_decode of mor1kx_decode.v
>     wire			decode_op_movhi_o;	// From mor1kx_decode of mor1kx_decode.v
> +   wire			decode_op_adrp_o;	// From mor1kx_decode of mor1kx_decode.v
>     wire			decode_op_mtspr_o;	// From mor1kx_decode of mor1kx_decode.v
>     wire			decode_op_mul_o;	// From mor1kx_decode of mor1kx_decode.v
>     wire			decode_op_mul_signed_o;	// From mor1kx_decode of mor1kx_decode.v
> @@ -458,6 +459,7 @@ module mor1kx_cpu_prontoespresso
>        .decode_op_shift_o		(decode_op_shift_o),
>        .decode_op_ffl1_o			(decode_op_ffl1_o),
>        .decode_op_movhi_o		(decode_op_movhi_o),
> +      .decode_op_adrp_o			(decode_op_adrp_o),
>        .decode_adder_do_sub_o		(decode_adder_do_sub_o),
>        .decode_adder_do_carry_o		(decode_adder_do_carry_o),
>        .decode_except_illegal_o		(decode_except_illegal_o),
> @@ -492,6 +494,7 @@ module mor1kx_cpu_prontoespresso
>      .op_mtspr_i				(decode_op_mtspr_o),
>      .op_mfspr_i				(decode_op_mfspr_o),
>      .op_movhi_i				(decode_op_movhi_o),
> +    .op_adrp_i				(decode_op_adrp_o),
>      .op_jbr_i				(decode_op_jbr_o),
>      .op_jr_i				(decode_op_jr_o),
>      .immjbr_upper_i			(decode_immjbr_upper_o),
> @@ -562,6 +565,7 @@ module mor1kx_cpu_prontoespresso
>        .op_mtspr_i			(decode_op_mtspr_o),	 // Templated
>        .op_mfspr_i			(decode_op_mfspr_o),	 // Templated
>        .op_movhi_i			(decode_op_movhi_o),	 // Templated
> +      .op_adrp_i			(decode_op_adrp_o),	 // Templated
>        .op_jbr_i				(decode_op_jbr_o),	 // Templated
>        .op_jr_i				(decode_op_jr_o),	 // Templated
>        .immjbr_upper_i			(decode_immjbr_upper_o), // Templated
> diff --git a/rtl/verilog/mor1kx_decode.v b/rtl/verilog/mor1kx_decode.v
> index 6163d3b..3c247b1 100644
> --- a/rtl/verilog/mor1kx_decode.v
> +++ b/rtl/verilog/mor1kx_decode.v
> @@ -114,6 +114,7 @@ module mor1kx_decode
>      output 			      decode_op_shift_o,
>      output 			      decode_op_ffl1_o,
>      output 			      decode_op_movhi_o,
> +    output 			      decode_op_adrp_o,
>  
>      // Sync operations
>      output                            decode_op_msync_o,
> @@ -262,6 +263,7 @@ module mor1kx_decode
>  			     opc_alu == `OR1K_ALU_OPC_FFL1;
>  
>     assign decode_op_movhi_o = opc_insn == `OR1K_OPCODE_MOVHI;
> +   assign decode_op_adrp_o = opc_insn == `OR1K_OPCODE_ADRP;
>  
>     // FPU related
>     generate
> @@ -279,6 +281,7 @@ module mor1kx_decode
>     // Which instructions cause writeback?
>     assign decode_rf_wb_o = (opc_insn == `OR1K_OPCODE_JAL |
>  			    opc_insn == `OR1K_OPCODE_MOVHI |
> +			    opc_insn == `OR1K_OPCODE_ADRP |
>  			    opc_insn == `OR1K_OPCODE_JALR |
>  			    opc_insn == `OR1K_OPCODE_LWA) |
>  			   // All '10????' opcodes except l.sfxxi
> @@ -326,10 +329,14 @@ module mor1kx_decode
>     assign imm_high = {decode_imm16_o, 16'd0};
>     assign imm_high_sel = decode_op_movhi_o;
>  
> +   assign imm_adrp = {decode_insn_i[18:0], 13'd0};
> +   assign imm_adrp_sel = declde_op_adrp_o;
> +
>     assign decode_immediate_o = imm_sext_sel ? imm_sext :
> -			       imm_zext_sel ? imm_zext : imm_high;
> +			       imm_zext_sel ? imm_zext :
> +                               imm_high_sel ? imm_high : imm_adrp;
>  
> -   assign decode_immediate_sel_o = imm_sext_sel | imm_zext_sel | imm_high_sel;
> +   assign decode_immediate_sel_o = imm_sext_sel | imm_zext_sel | imm_high_sel | imm_adrp_sel;
>  
>     // ALU opcode
>     assign opc_alu = decode_insn_i[`OR1K_ALU_OPC_SELECT];
> @@ -397,6 +404,7 @@ module mor1kx_decode
>  	`OR1K_OPCODE_SFLES,
>  	*/
>         `OR1K_OPCODE_SF,
> +       `OR1K_OPCODE_ADRP,
>         `OR1K_OPCODE_NOP:
>  	 decode_except_illegal_o = 1'b0;
>  
> diff --git a/rtl/verilog/mor1kx_decode_execute_cappuccino.v b/rtl/verilog/mor1kx_decode_execute_cappuccino.v
> index 8d48b12..b99a289 100644
> --- a/rtl/verilog/mor1kx_decode_execute_cappuccino.v
> +++ b/rtl/verilog/mor1kx_decode_execute_cappuccino.v
> @@ -130,6 +130,7 @@ module mor1kx_decode_execute_cappuccino
>      input 				  decode_op_shift_i,
>      input 				  decode_op_ffl1_i,
>      input 				  decode_op_movhi_i,
> +    input 				  decode_op_adrp_i,
>      input                                 decode_op_msync_i,
>      input [`OR1K_FPUOP_WIDTH-1:0]         decode_op_fpu_i,
>  
> @@ -168,6 +169,7 @@ module mor1kx_decode_execute_cappuccino
>      output reg 				  execute_op_shift_o,
>      output reg 				  execute_op_ffl1_o,
>      output reg 				  execute_op_movhi_o,
> +    output reg 				  execute_op_adrp_o,
>      output reg 				  execute_op_bf_o,
>      output reg 				  execute_op_bnf_o,
>      output reg                            execute_op_msync_o,
> @@ -233,6 +235,7 @@ module mor1kx_decode_execute_cappuccino
>  	execute_op_shift_o <= 1'b0;
>  	execute_op_ffl1_o <= 1'b0;
>  	execute_op_movhi_o <= 1'b0;
> +	execute_op_adrp_o <= 1'b0;
>          execute_op_msync_o <= 1'b0;
>  	execute_op_mfspr_o <= 1'b0;
>  	execute_op_mtspr_o <= 1'b0;
> @@ -259,6 +262,7 @@ module mor1kx_decode_execute_cappuccino
>  	execute_op_shift_o <= 1'b0;
>  	execute_op_ffl1_o <= 1'b0;
>  	execute_op_movhi_o <= 1'b0;
> +	execute_op_adrp_o <= 1'b0;
>          execute_op_msync_o <= 1'b0;
>  	execute_op_lsu_load_o <= 1'b0;
>  	execute_op_lsu_store_o <= 1'b0;
> @@ -283,6 +287,7 @@ module mor1kx_decode_execute_cappuccino
>  	execute_op_shift_o <= decode_op_shift_i;
>  	execute_op_ffl1_o <= decode_op_ffl1_i;
>  	execute_op_movhi_o <= decode_op_movhi_i;
> +	execute_op_adrp_o <= decode_op_adrp_i;
>          execute_op_msync_o <= decode_op_msync_i;
>  	execute_op_mfspr_o <= decode_op_mfspr_i;
>  	execute_op_mtspr_o <= decode_op_mtspr_i;
> @@ -309,6 +314,7 @@ module mor1kx_decode_execute_cappuccino
>  	   execute_op_shift_o <= 1'b0;
>  	   execute_op_ffl1_o <= 1'b0;
>  	   execute_op_movhi_o <= 1'b0;
> +	   execute_op_adrp_o <= 1'b0;
>             execute_op_msync_o <= 1'b0;
>  	   execute_op_mtspr_o <= 1'b0;
>  	   execute_op_mfspr_o <= 1'b0;
> diff --git a/rtl/verilog/mor1kx_execute_alu.v b/rtl/verilog/mor1kx_execute_alu.v
> index 7157859..bc8c863 100644
> --- a/rtl/verilog/mor1kx_execute_alu.v
> +++ b/rtl/verilog/mor1kx_execute_alu.v
> @@ -88,6 +88,7 @@ module mor1kx_execute_alu
>      input 			      op_mtspr_i,
>      input 			      op_mfspr_i,
>      input 			      op_movhi_i,
> +    input 			      op_adrp_i,
>      input [`OR1K_FPUOP_WIDTH-1:0]   op_fpu_i,
>      input [`OR1K_FPCSR_RM_SIZE-1:0] fpu_round_mode_i,
>      input 			      op_jbr_i,
> @@ -179,12 +180,14 @@ module mor1kx_execute_alu
>     wire [OPTION_OPERAND_WIDTH-1:0]        decode_b;
>  generate
>  if (CALCULATE_BRANCH_DEST=="TRUE") begin : calculate_branch_dest
> -   assign a = (op_jbr_i | op_jr_i) ? pc_execute_i : rfa_i;
> +   assign a = (op_jbr_i | op_jr_i) ? pc_execute_i
> +	      : op_adrp_i ? {pc_execute_i[31:13], 13'b0}
> +	      : rfa_i;
>     assign b = immediate_sel_i ? immediate_i :
>                op_jbr_i ? {{4{immjbr_upper_i[9]}},immjbr_upper_i,imm16_i,2'b00} :
>                rfb_i;
>  end else begin
> -   assign a = rfa_i;
> +   assign a = op_adrp_i ? {pc_execute_i[31:13], 13'b0} : rfa_i;
>     assign b = immediate_sel_i ? immediate_i : rfb_i;
>  
>     assign decode_a = decode_rfa_i;

> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc

