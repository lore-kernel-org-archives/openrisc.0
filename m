From: Olof Kindgren <olof.kindgren@gmail.com>
Date: Mon, 18 Apr 2016 17:15:29 +0200
Subject: [OpenRISC] [Openrisc] Bug in or1200 ITLB miss exception
	handling...
In-Reply-To: <D90E780DD5090A4F9AEBC859615CED77874D2968@OXYGEN.aacmicrotec.local>
References: <D90E780DD5090A4F9AEBC859615CED778731BCC1@OXYGEN.aacmicrotec.local>
 <D90E780DD5090A4F9AEBC859615CED778731BCDC@OXYGEN.aacmicrotec.local>
 <D90E780DD5090A4F9AEBC859615CED77874D2968@OXYGEN.aacmicrotec.local>
Message-ID: <CAKaYPCO_QmRuK8ucLxjKazgVqofkeWfwmB=HAskhz_=GojUzGQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Found this old mail and forwarding it to the new OpenRISC mailing
list. According to our silent ack principle, we should apply and be
happy. Anyone up for fixing this?

//Olof

On Fri, Nov 6, 2015 at 10:56 AM, Jakob Viketoft
<jakob.viketoft@aacmicrotec.com> wrote:
> Hello!
>
> For anyone interested, it seems that later testing at our site has revealed this bug fix to only fix the symptoms and that further (extensive) digging seem to have found the real cause. As this still covers the or1200, there might not be that many people interested, but I still thought it'd be a good idea to post it here so anyone else can benefit as well.
>
> What seem to be the original problem is that an ack from an external (wishbone) access is forwarded to an internal access without checking that the two accesses are to the same address. This typically happens during exceptions where the internal access is aborted and then a new access fires to a new address, but the external access stay active the whole time. In our memory controller this is more apparent due to the round-robin operation of it where the CPU might have to wait a bit longer at times due to DMA accesses to the memory from other IP cores.
>
> Please see the patch inlined below.
>
>       /Jakob
>
> diff --git a/hdl/or1200_ic_fsm.v b/hdl/or1200_ic_fsm.v
> index ded701f..45c9e77 100644
> --- a/hdl/or1200_ic_fsm.v
> +++ b/hdl/or1200_ic_fsm.v
> @@ -107,6 +107,7 @@ reg                         hitmiss_eval;
>  reg                            load;
>  reg                            cache_inhibit;
>  reg                            last_eval_miss; // JPB
> +reg                            ic_biu_equal;
>
>     //
>     // Generate of ICRAM write enables
> @@ -130,7 +131,7 @@ reg                                 last_eval_miss; // JPB
>     // cache line is ready (on the bus)
>     // Cache hits overpower bus data
>     assign first_miss_ack = (state == `OR1200_ICFSM_CFETCH) & biudata_valid &
> -                          ~first_hit_ack;
> +                          ic_biu_equal & ~first_hit_ack;
>
>     // Asserted when a cache occurs, but there was a bus error with handling
>     // the old line or fetching the new line
> @@ -142,6 +143,15 @@ reg                                last_eval_miss; // JPB
>     assign burst = (state == `OR1200_ICFSM_CFETCH) & tagcomp_miss &
>                   !cache_inhibit | (state == `OR1200_ICFSM_LREFILL3);
>
> +   // Compare outgoing and incoming addresses and set a flag accordingly
> +   always @(posedge clk or `OR1200_RST_EVENT rst)
> +     if (rst == `OR1200_RST_VALUE)
> +       ic_biu_equal <= 1'b0;
> +     else if (saved_addr_r[31:4] == start_addr[31:4])
> +       ic_biu_equal <= 1'b1;
> +     else
> +       ic_biu_equal <= 1'b0;
> +
>     //
>     // Main IC FSM
>     //
>
>
>
> Jakob Viketoft
> Senior Engineer in RTL and embedded software
>
> ÅAC Microtec AB
> Dag Hammarskjölds väg 48
> SE-751 83 Uppsala, Sweden
>
> T: +46 702 80 95 97
> http://www.aacmicrotec.com
>
> ________________________________________
> From: Jakob Viketoft
> Sent: Monday, November 17, 2014 10:44
> To: openrisc at lists.opencores.org; openrisc at lists.openrisc.net
> Subject: RE: Bug in or1200 ITLB miss exception handling...
>
> Of course, I meant it to read that the IMMU is turned *OFF* at the start of the exception, but anyways... :)
>
>     /Jakob
>
> ________________________________________
> From: openrisc-bounces at lists.openrisc.net [openrisc-bounces at lists.openrisc.net] on behalf of Jakob Viketoft [jakob.viketoft at aacmicrotec.com]
> Sent: Monday, November 17, 2014 10:41
> To: openrisc at lists.opencores.org; openrisc at lists.openrisc.net
> Subject: [OpenRISC] Bug in or1200 ITLB miss exception handling...
>
> Hello!
>
> We have developed a new memory controller to use with the openrisc core, but using it in Linux caused a bus error. After lots of digging trying to find the fault with the new memory controller, it turns out that there is a bug in the or1200 exception handling. I don't know exactly why only the new memory controller uncovered this bug, but when looking at the present code I'm a bit puzzled as to why it didn't seem to occur for anyone else.
>
> I don't know if everyone else stopped using this core, but I thought it would be good to put the fix out there if someone else could benefit from it and also perhaps to get some more eyes onto whether this was the right fix or not. Since the bugzilla that's been used before seem to have gone off the deep end, I post this in this e-mail in the hope it's visible enough.
>
> I would also like to add a few words of how I see the nature of the bug. When an ITLB miss occur, the internal icpu_err signal is held high which in turn trigger the ITLB miss exception. This in turn sets the FSM in the exception module going which (among other things) generate the extend_flush signal. The FSM is supposed to wait until such time as any outstanding instruction access is finished and so flushing this as well before going to the exception vector. However, the icpu_error signal coming from the MMU is held high a bit too long and caught by the flushpipe_r always block which dutifully sets flushpipe_r, this triggers genpc_freeze to go high which in turn moves the FSM in the exception module along. This lowers the extend_flush (and hence flushpipe signal) regardless of how the instruction fetch is going. If the instruction fetch is slower than the length of the flushpipe signal, the instruction won't be flushed and instead executed. Our bus error stems from the situ
>  ation when this instruction is a load or store where it's virtual address is now used as a physical address (with no recipient) since the IMMU have been turned on at the start of the exception. I have corrected the bug by putting a condition of genpc_freeze's ability to move the exception FSM along if there is an ongoing wishbone instruction fetch at the start of the exception.
>
> I might add that the new memory controller uses a round-robin scheme for arbitration and that there's more going on on the buses to it apart from cpu.
>
> Anyway, the bug fix is inlined below, comments are welcome.
>
> Best regards,
>
>        /Jakob
>
> diff --git a/hdl/or1200_cpu.v b/hdl/or1200_cpu.v
> index de5a854..e422d3e 100644
> --- a/hdl/or1200_cpu.v
> +++ b/hdl/or1200_cpu.v
> @@ -81,7 +81,7 @@ module or1200_cpu(
>         boot_adr_sel_i,
>
>         // Interrupt & tick exceptions
> -       sig_int, sig_tick, sig_trap,
> +       sig_int, sig_tick, sig_trap, iwb_cyc_i, iwb_ack_i, iwb_err_i,
>
>         // SPR interface
>         supv, spr_addr, spr_dat_cpu, spr_dat_pic, spr_dat_tt, spr_dat_pm,
> @@ -213,6 +213,13 @@ input                      mtspr_dc_done;
>  input                          sig_int;
>  input                          sig_tick;
>  output                         sig_trap;
> +
> +//
> +// External instruction fetch signals
> +//
> +input                          iwb_cyc_i;
> +input                          iwb_ack_i;
> +input                          iwb_err_i;
>
>  //
>  // Register file parity error indicator
> @@ -858,6 +865,9 @@ or1200_except or1200_except(
>         .sig_fp(sig_fp),
>         .fpcsr_fpee(fpcsr[`OR1200_FPCSR_FPEE]),
>         .ex_branch_taken(ex_branch_taken),
> +       .iext_cycstb_i(iwb_cyc_i),
> +       .iext_ack_i(iwb_ack_i),
> +       .iext_err_i(iwb_err_i),
>         .icpu_ack_i(icpu_ack_i),
>         .icpu_err_i(icpu_err_i),
>         .dcpu_ack_i(dcpu_ack_i),
> diff --git a/hdl/or1200_except.v b/hdl/or1200_except.v
> index d7cc6bd..da6b2a6 100644
> --- a/hdl/or1200_except.v
> +++ b/hdl/or1200_except.v
> @@ -78,8 +78,8 @@ module or1200_except
>     except_stop, except_trig, ex_void, abort_mvspr, branch_op, spr_dat_ppc,
>     spr_dat_npc, datain, du_dsr, epcr_we, eear_we, esr_we, pc_we, epcr, eear,
>     du_dmr1, du_hwbkpt, du_hwbkpt_ls_r, esr, sr_we, to_sr, sr, lsu_addr,
> -   abort_ex, icpu_ack_i, icpu_err_i, dcpu_ack_i, dcpu_err_i, sig_fp, fpcsr_fpee,
> -   dsx
> +   abort_ex, iext_cycstb_i, iext_ack_i, iext_err_i, icpu_ack_i, icpu_err_i,
> +   dcpu_ack_i, dcpu_err_i, sig_fp, fpcsr_fpee, dsx
>
>  );
>
> @@ -144,6 +144,9 @@ output      [31:0]                  spr_dat_ppc;
>  output [31:0]                  spr_dat_npc;
>  output                         abort_ex;
>  output              abort_mvspr;
> +input                          iext_cycstb_i;
> +input                          iext_ack_i;
> +input                          iext_err_i;
>  input                          icpu_ack_i;
>  input                          icpu_err_i;
>  input                          dcpu_ack_i;
> @@ -168,6 +171,7 @@ reg [2:0]                   ex_exceptflags;
>  reg    [`OR1200_EXCEPTFSM_WIDTH-1:0]   state;
>  reg                            extend_flush;
>  reg                            extend_flush_last;
> +reg                            iext_access;
>  reg                            ex_dslot /* verilator public */;
>  reg                            delayed1_ex_dslot;
>  reg                            delayed2_ex_dslot;
> @@ -461,6 +465,7 @@ assign except_flushpipe = |except_trig & ~|state;
>          state <=  `OR1200_EXCEPTFSM_IDLE;
>          except_type <=  `OR1200_EXCEPT_NONE;
>          extend_flush <=  1'b0;
> +        iext_access <= 1'b0;
>          epcr <=  32'b0;
>          eear <=  32'b0;
>          esr <=  {2'h1, {`OR1200_SR_WIDTH-3{1'b0}}, 1'b1};
> @@ -477,6 +482,12 @@ assign except_flushpipe = |except_trig & ~|state;
>                if (except_flushpipe) begin
>                   state <=  `OR1200_EXCEPTFSM_FLU1;
>                   extend_flush <=  1'b1;
> +                 if (iext_cycstb_i && !iext_ack_i && !iext_err_i) begin
> +                    // An instruction access is under way when exception arrives
> +                    iext_access <= 1'b1;
> +                 end else begin
> +                    iext_access <= 1'b0;
> +                 end
>                   esr <=  sr_we ? to_sr : sr;
>                   casez (except_trig)
>  `ifdef OR1200_EXCEPT_ITLBMISS
> @@ -628,8 +639,11 @@ assign except_flushpipe = |except_trig & ~|state;
>                     esr <=  {datain[`OR1200_SR_WIDTH-1], 1'b1, datain[`OR1200_SR_WIDTH-3:0]};
>                end
>              `OR1200_EXCEPTFSM_FLU1:
> -              if (icpu_ack_i | icpu_err_i | genpc_freeze)
> -                state <=  `OR1200_EXCEPTFSM_FLU2;
> +                 // Wait here until a possible ongoing access is finished
> +                 if (icpu_ack_i | icpu_err_i | (!iext_access & genpc_freeze)) begin
> +                    iext_access <= 1'b0;
> +                    state <=  `OR1200_EXCEPTFSM_FLU2;
> +                 end
>              `OR1200_EXCEPTFSM_FLU2:
>  `ifdef OR1200_EXCEPT_TRAP
>                if (except_type == `OR1200_EXCEPT_TRAP) begin
> diff --git a/hdl/or1200_top.v b/hdl/or1200_top.v
> index 947ab4f..5243b0c 100644
> --- a/hdl/or1200_top.v
> +++ b/hdl/or1200_top.v
> @@ -728,6 +728,9 @@ or1200_cpu(
>         .sig_int(sig_int),
>         .sig_tick(sig_tick),
>         .sig_trap(sig_trap),
> +       .iwb_cyc_i(iwb_cyc_o),
> +       .iwb_ack_i(iwb_ack_i),
> +       .iwb_err_i(iwb_err_i),
>
>         // SPRs
>         .supv(supv),
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.openrisc.net
> http://lists.openrisc.net/listinfo/openrisc
> _______________________________________________
> Openrisc mailing list
> Openrisc at lists.opencores.org
> http://lists.opencores.org/listinfo/openrisc

