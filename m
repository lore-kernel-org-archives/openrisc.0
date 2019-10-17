From: ecalvo@2se.es <ecalvo@2se.es>
Date: Thu, 17 Oct 2019 17:01:03 +0200
Subject: [OpenRISC] PCCR and PCRM registers
In-Reply-To: <CAAfxs76G9Tyygv-5F+y-v9WkKyqO99W2aiBtejB54-qV-OBiFQ@mail.gmail.com>
References: <009d01d58416$7125fe80$5371fb80$@2se.es>
 <CAAfxs76G9Tyygv-5F+y-v9WkKyqO99W2aiBtejB54-qV-OBiFQ@mail.gmail.com>
Message-ID: <00ef01d584fb$b271ae30$17550a90$@2se.es>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hi Stafford, 

 

Yes, I am using newlib. I had discovered both files; these registers in sprs.h 

 

/******************************/

/* Performance Counters Group */

/******************************/

#define OR1K_SPR_PERF_GROUP 0x07

 

/* Performance Counters Count Registers */

#define OR1K_SPR_PERF_PCCR_BASE     OR1K_UNSIGNED(0x000)

#define OR1K_SPR_PERF_PCCR_COUNT    OR1K_UNSIGNED(0x008)

#define OR1K_SPR_PERF_PCCR_STEP     OR1K_UNSIGNED(0x001)

#define OR1K_SPR_PERF_PCCR_INDEX(N) (OR1K_SPR_PERF_PCCR_BASE + ((N) * OR1K_SPR_PERF_PCCR_STEP))

#define OR1K_SPR_PERF_PCCR_ADDR(N)  ((OR1K_SPR_PERF_GROUP << OR1K_SPR_GROUP_LSB) | OR1K_SPR_PERF_PCCR_INDEX(N))

 

/* Performance Counters Mode Registers */

#define OR1K_SPR_PERF_PCMR_BASE     OR1K_UNSIGNED(0x008)

#define OR1K_SPR_PERF_PCMR_COUNT    OR1K_UNSIGNED(0x008)

#define OR1K_SPR_PERF_PCMR_STEP     OR1K_UNSIGNED(0x001)

#define OR1K_SPR_PERF_PCMR_INDEX(N) (OR1K_SPR_PERF_PCMR_BASE + ((N) *OR1K_SPR_PERF_PCMR_STEP))

#define OR1K_SPR_PERF_PCMR_ADDR(N)  ((OR1K_SPR_PERF_GROUP << OR1K_SPR_GROUP_LSB) | OR1K_SPR_PERF_PCMR_INDEX(N))

 

/* Performance Counters Configuration */

#define OR1K_SPR_SYS_PCCFGR_INDEX OR1K_UNSIGNED(0x008)

#define OR1K_SPR_SYS_PCCFGR_ADDR  OR1K_UNSIGNED(0x0008)

 

/* Number of Performance Counters */

#define OR1K_SPR_SYS_PCCFGR_NPC_LSB    0

#define OR1K_SPR_SYS_PCCFGR_NPC_MSB    2

#define OR1K_SPR_SYS_PCCFGR_NPC_BITS   3

#define OR1K_SPR_SYS_PCCFGR_NPC_MASK   OR1K_UNSIGNED(0x00000007)

#define OR1K_SPR_SYS_PCCFGR_NPC_GET(X) (((X) >> 0) & OR1K_UNSIGNED(0x00000007))

#define OR1K_SPR_SYS_PCCFGR_NPC_SET(X, Y) (((X) & OR1K_UNSIGNED(0xfffffff8)) | ((Y) << 0))

 

And these functions in support.h

 

static inline void or1k_mtspr (uint32_t spr, uint32_t value)

static inline uint32_t or1k_mfspr (uint32_t spr)

 

Despite this I don’t have clear how to use it. 

 

1.	If I do: or1k_mtspr (OR1K_SPR_SYS_PCCFGR_ADDR , 0)  -> Does it allow me to configure the PCCFGR to one performance counter?

Is This the same than or1k_mtspr (OR1K_SPR_SYS_PCCFGR_ADDR , OR1K_SPR_SYS_PCCFGR_NPC_LSB ) or  Do OR1K_SPR_SYS_PCCFGR_NPC_LSB   , OR1K_SPR_SYS_PCCFGR_NPC_MSB, etc. provide different functions on each one performance counter?

2.	What is the meaning of PCCR_BASE,  PCCR_COUNT, PCCR_STEP, PCMR_INDEX(N), PCMR_ADDR(N) ? (the same for PCMR) (Is BASE the base address of all PCCR and ADDR the position of each one of them? ….why PCMR_BASE and COUNT hasta de same value OR1K_UNSIGNED(0x008)? )      
3.	Should I define first PCCFGR, second PCMR and last get PCCR?

 

Thanks and sorry for the inconveniences.

Elisa

 

De: Stafford Horne <shorne@gmail.com> 
Enviado el: jueves, 17 de octubre de 2019 7:14
Para: ecalvo at 2se.es; Openrisc <openrisc@lists.librecores.org>
Asunto: Re: PCCR and PCRM registers

 

+cc mailing list,

 

Hi Elisa,

 

Which toolchain are you using? I guess newlib?

 

It has functions like or1k_mfspr() and or1k_mtspr() see or1k-support.h and or1k-sprs.h headers for details.

 

-Stafford

On Wed, Oct 16, 2019, 8:40 PM < <mailto:ecalvo@2se.es> ecalvo at 2se.es> wrote:

Hi Stafford, 

I am with PCCR and PCRM registers. I have seen that I can access from asm language, but there is functions to access from C? Have you got any example about their usage?

I have already confirmed my subscription to the mailing list. 

Thanks 
Elisa

-----Mensaje original-----
De: Stafford Horne < <mailto:shorne@gmail.com> shorne at gmail.com> 
Enviado el: miércoles, 9 de octubre de 2019 13:38
Para:  <mailto:ecalvo@2se.es> ecalvo at 2se.es; Julius Baxter < <mailto:juliusbaxter@gmail.com> juliusbaxter at gmail.com>
Asunto: Re: other doubt

Hello Elisa,

If you simulate with Icarus or modelsim you will be able to measure pretty much the same performance characteristics as FPGA. So there is no need to go straight to FPGA.

In terms of my example C code is one option.  You can also read timer data directly from the tick timer in assembly and achieve the same thing.

If you are interested we can CC the mailing list and get more opinions.

-Stafford

On Wed, Oct 9, 2019 at 5:09 PM < <mailto:ecalvo@2se.es> ecalvo at 2se.es> wrote:
>
> Hi Stafford,
>
> Nice to meet you and, first of all, thanks a lot for your guidance. I am new on this, and although there is some documentation, sometimes it is difficult some point which maybe it is basic.
>
> Ok, to your comments. If.."A simulator like QEMU or or1ksim will not give and exact representation of the CPUs real time performance"...then...if I simulate directly the processor with modelsim, icarus or a similar tool...neither I get a real performance, don’t I? And values for the counters that you tell me to enable, neither are real, isn't it? should I execute it directly on the FPGA and it will depends on the implementation?
>
> Ok, to C code. I have understood the dependency with toolchain.
>
> Thanks a lot again.
> Best regards,
> Elisa
>
>
> -----Mensaje original-----
> De: Stafford Horne < <mailto:shorne@gmail.com> shorne at gmail.com>
> Enviado el: martes, 8 de octubre de 2019 16:18
> Para: Julius Baxter < <mailto:juliusbaxter@gmail.com> juliusbaxter at gmail.com>
> CC:  <mailto:ecalvo@2se.es> ecalvo at 2se.es
> Asunto: Re: other doubt
>
> Hi Elisa,
>
> OpenRISC cpu's can run any algorithm, but how well it will perform depends on many things:
>
>   - Compiler optimization flags (i.e. -O3)
>   - Whether or not you are doing FPU instructions and have FPU enabled
>   - Whether or not you use multiply and divide and have these instructions
>     enabled
>   - The frequency you are running
>   - Cache settings Icache Dcache
>   - The type of algorithm, does it require lots of data which will cause many
>     cache misses?
>
> A simulator like QEMU or or1ksim will not give and exact representation of the CPUs real time performance.  It can tell you which intructions will be executed, but not how fast those will run or how many pipeline stalls of cache misses will happen.
>
> You can use the performance counters, they are supported in mor1kx if you enable them with the FEATURE_PERFCOUNTERS='ENABLED' parameter.  They can help count how many events happen between certain events.  Then you can combine them with a timer and watchpoints to detect how many times a loop can execute in 1000 clock cycles etc.  Please read about PCCRn and PCMRn in the architecture manual.
>
> It might be just as easy to use simple timing in a c program though, depending on the toolchain you use you can compare times between runs of your algorithm.
> i.e.
>
>     #include <time.h>
>     #include <stdio.h>
>
>     static long to_micro(struct timespec *time) {
>       return (time->tv_sec * 1000000) + (time->tv_nsec / 1000);
>     }
>
>     int main() {
>       int i, j = 0;
>
>       struct timespec before, after;
>
>       clock_gettime(CLOCK_MONOTONIC, &before);
>       /* Super complex algorithm */
>       for (int i = 0; i < 100; i++) {
>         j = (j+1) * (j+2);
>       }
>       clock_gettime(CLOCK_MONOTONIC, &after);
>
>       printf("time to run algorithm %ld uSecs\n", to_micro(&after) - 
> to_micro(&before));
>
>       return 0;
>     }
>
> $ or1k-smh-linux-gnu-gcc timer.c
> $ ./glibc-build-scripts/qemu-or1k-libc ./a.out time to run algorithm 
> 164 uSecs
>
> I hope it helps.
>
> -Stafford
>
> On Tue, Oct 08, 2019 at 10:54:29PM +1100, Julius Baxter wrote:
> > Hi,
> >
> > No problem.
> >
> > There are performance counters in the OpenRISC architecture but 
> > whether they're implemented in a particular implementation is another matter.
> >
> > You can use these registers to measure various things the CPU is 
> > doing while it's executing. If you read the ISA document it'll tell 
> > you about them.
> >
> > I'm CCing Stafford because he's the main OpenRISC man these days and 
> > probably knows about the state of the performance counter registers 
> > in various simulators and RTL implementations.
> >
> > Cheers,
> > Julius
> >
> > On Tue., 8 Oct. 2019, 10:43 pm , < <mailto:ecalvo@2se.es> ecalvo at 2se.es> wrote:
> >
> > > Hi Julius,
> > >
> > >
> > >
> > > Sorry for bothering you again ☹. Can I do you other fast question 
> > > related to openrisc? If not, ignore the email please.
> > >
> > >
> > >
> > > Is there any way to characterize the type of application that I 
> > > can run in openrisc? I mean, could you measure (with numbers) if 
> > > an algorithm can be executed on it and the speed that it will achieve?
> > > Is it possible to do it using orksim?
> > >
> > >
> > >
> > > Sorry because maybe it is so basic and general ☹
> > >
> > >
> > >
> > > Thanks in advance
> > >
> > > Elisa
> > >
> > >
> > >
> > >
> > >
> > > *De:* Julius Baxter < <mailto:juliusbaxter@gmail.com> juliusbaxter at gmail.com> *Enviado el:* lunes, 
> > > 16 de septiembre de 2019 13:11
> > > *Para:*  <mailto:ecalvo@2se.es> ecalvo at 2se.es
> > > *Asunto:* Re: Starting with OpenRISC - IOBs
> > >
> > >
> > >
> > > Also! To let you know, if you're in Spain, we will soon be having 
> > > our ORConf conference in Europe, and it's in Bordeaux, France, 
> > > just across the border. :)
> > >
> > >
> > >
> > > There are several people there who can help you get up to speed, 
> > > one of whom is Stafford Horne who knows most about the OpenRISC IP 
> > > lately. He will be presenting. If you can attend, it'd be helpful, I'm sure.
> > >
> > >
> > >
> > > All info at  <https://orconf.org> https://orconf.org
> > >
> > >
> > >
> > > Cheers,
> > >
> > > Julius
> > >
> > >
> > >
> > > On Mon, 16 Sep 2019 at 21:09, Julius Baxter 
> > > < <mailto:juliusbaxter@gmail.com> juliusbaxter at gmail.com>
> > > wrote:
> > >
> > > Hi Elisa,
> > >
> > >
> > >
> > > Sorry for the delay in this response.
> > >
> > >
> > >
> > > You should be using an SoC toplevel. FPGAs have everything you 
> > > need on board like memories and IO blocks and lots of other FPGA 
> > > fabric for you to implement other pieces of hardware.
> > >
> > >
> > >
> > > FuseSoC provides a really nice and easy way to build an mor1kx 
> > > design for the DE0 nano I believe:
> > >
> > >
> > >
> > >  <https://github.com/olofk/de0_nano> https://github.com/olofk/de0_nano
> > >
> > >
> > >
> > > That github page has a rough guide to getting it going.
> > >
> > >
> > >
> > > If you need help I recommend posting to the OpenRISC mailing list 
> > > and people will respond probably more promptly than I. (I 
> > > recommend getting to know how to use mailing lists.
> > >  <https://openrisc.io/community> https://openrisc.io/community
> > >
> > >
> > >
> > > There are more resources here:  <https://openrisc.io/tutorials> https://openrisc.io/tutorials
> > >
> > >
> > >
> > > I hope that's helpful.
> > >
> > >
> > >
> > > Cheers,
> > >
> > > Julius
> > >
> > >
> > >
> > >
> > >
> > > On Wed, 11 Sep 2019 at 20:09, < <mailto:ecalvo@2se.es> ecalvo at 2se.es> wrote:
> > >
> > > Hi Julius,
> > >
> > >
> > >
> > > Thanks a lot for the quick answer.
> > >
> > >
> > >
> > > Yes, this is the problem: I am using as top level the mor1kx 
> > > module itself. You mean that I need to synthetize also in 
> > > reconfigurable logic these cores, don’t you? I thought that I 
> > > could have these elements as external in a development board.
> > >
> > >
> > >
> > > Thanks again,
> > >
> > > Cheers
> > >
> > > Elisa
> > >
> > >
> > >
> > > *De:* Julius Baxter < <mailto:juliusbaxter@gmail.com> juliusbaxter at gmail.com> *Enviado el:* 
> > > miércoles, 11 de septiembre de 2019 12:02
> > > *Para:*  <mailto:ecalvo@2se.es> ecalvo at 2se.es
> > > *Asunto:* Re: Starting with OpenRISC - IOBs
> > >
> > >
> > >
> > > Hi Elisa,
> > >
> > >
> > >
> > > Thanks for getting in touch, that sounds like a cool project.
> > >
> > >
> > >
> > > Can you tell me about the toplevel - are you using a system 
> > > toplevel, or is your toplevel the mor1kx module itself?
> > >
> > >
> > >
> > > If it's the latter, then that's not the best way to do it - you 
> > > need a system toplevel which instantiates memories and some reset 
> > > circuitry and likely some IO (UART, GPIO, JTAG debug, etc.) to talk to the outside world.
> > >
> > >
> > >
> > > Is that helpful?
> > >
> > >
> > >
> > > Cheers,
> > >
> > > Julius
> > >
> > >
> > >
> > > On Wed, 11 Sep 2019 at 19:47, < <mailto:ecalvo@2se.es> ecalvo at 2se.es> wrote:
> > >
> > > Dear Dr. Baxter,
> > >
> > >
> > >
> > > My name is Elisa Calvo Gallego. I am writing you because I have 
> > > started to work with OpenRISC in the framework of a research 
> > > project developed in the company where I am working (Space 
> > > Submicron Electronics, 2SE), and I am having some basic troubles. Could you help me?
> > >
> > >
> > >
> > > Although the FPGA that we are planning to use is larger, I have 
> > > synthetized mor1kx for a DE0 nano board as first step (this is the 
> > > board used in the majority of guides and tutorials). My problem is 
> > > that the results that I have obtained are similar in area and 
> > > resources, except for IOBs, which are more than available IOBs in 
> > > the device. Do you know what I am doing wrong? Should I comment 
> > > debug lines or something like that? I apologize if the question is 
> > > immediate. I didn't find the answer and I'm new in this.
> > >
> > >
> > >
> > > Thanks very much in advance.
> > >
> > > Best regards,
> > >
> > >
> > >
> > > Elisa
> > >
> > >
>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20191017/23f38c86/attachment-0001.html>
