From: Nektarios Georgios Tsoutsos <nektarios.tsoutsos@nyu.edu>
Date: Tue, 1 Nov 2016 20:57:55 +0400
Subject: [OpenRISC] Embedded Security Challenge on the OpenRISC platform
In-Reply-To: <CAF6YiZ7d3QsZfq2bJKMfzFFNNOe6wQJuPDD5CZYyvNLLaeWxaw@mail.gmail.com>
References: <CAF6YiZ7d3QsZfq2bJKMfzFFNNOe6wQJuPDD5CZYyvNLLaeWxaw@mail.gmail.com>
Message-ID: <000701d23461$18b2f8a0$4a18e9e0$@nyu.edu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello Julius,
 
It's great to hear from you. Indeed, the Embedded Security Challenge this year focuses on improving the OpenRISC Arch/uArch to mitigate some very common attacks happening at the software level. Since memory corruption attacks are prominent in software (e.g., buffer overflows, return oriented programming etc.), we asked the teams to improve the hardware design (and if needed the compiler as well), to prevent such attacks. As an example, the github page has 4 sample exploits that modify the control flow of a Linux program and cause unintentional effects (https://github.com/nekt/csaw_esc_2016/tree/master/tools/exploits). Of course, no one suggests that the OpenRISC itself is vulnerable, but in case the software is vulnerable then the hardware can help preventing the exploit. There are different examples on how this can be done: using hardware-based shadow stacks, encoding return addresses and pointers at the hardware level, matching call/ret pairs etc. We anticipate such solutions from the teams at the finals on Nov 11.
 
When the challenge was designed in June, the plan was to select the most promising and efficient solutions, and then ask the teams to contribute to the upstream project. That was actually one of the reasons we chose a mature and well documented project like OpenRISC, as the work from the teams can have an impact. Typically, the finalists try to publish their results at academic conferences in the months following the competition, so I believe they will be happy to share their findings with the community. Also, presenting the findings at a venue such as ORCONF would be great as well.
 
Putting the framework together was generally straightforward. Our current github repo hosts some basic setup instructions (I am sure there are better tutorials out there), a Makefile to download precompiled toolchains and wrap around fusesoc commands etc., as well as an Ubuntu VM (http://tinyurl.com/csaw-esc16-vm) with the necessary software pre-installed (except for a stripped-down Quartus, which is included but not installed). The VM allows someone to have a working de0-nano prototype very quickly. Regarding feedback from the teams, the most frequent issue was about debugging processes on OpenRISC Linux on the FPGA through gdb/gdbserver (the teams had trouble compiling the gdbserver using the musl toolchain). Some participants also had some trouble getting UART on de0-nano to work with putty, but this was quickly resolved.
 
I will keep you posted with additional feedback after the competition finals in New York next week. I am also copying here Mihalis, who is the organizing faculty for this competition and can help so that the competition findings reach a wider audience.
 
Best,
Nektarios

-----Original Message-----
From: Julius Baxter [mailto:juliusbaxter at gmail.com] 
Sent: Tuesday, November 1, 2016 2:27 AM
To: nektarios.tsoutsos@nyu.edu
Cc: openrisc at lists.librecores.org
Subject: Embedded Security Challenge on the OpenRISC platform

Hi Nektarios,

I'm getting in touch because this year's ESC
(https://github.com/nekt/csaw_esc_2016) has come to our attention and it looks very interesting.

Correct me if I'm wrong but part of the competition involves understanding the OR1k ISA and looking for any potential vulnerabilities, so too the RTL implementations? I think we're very much interested in any security analysis of the OpenRISC architecture, not only from an academic point of view, but with a view to potentially revising the spec to address any issues. The same goes for the mor1kx RTL, which I understand is being used for the competition.
We'd very much be interested in seeing any security additions that come out of the competition be made available to review. Now of course the licensing terms don't require this, but is it the case that teams will publish their work?

Anyway, it's nice to use that you chose to use the OpenRISC SoC on the
de0 nano and FuseSoC to pull it together. We'd be interested to hear your experience on putting it together, whether you have any feedback on setting the platform up to use.

I've copied in the OpenRISC list because I think anyone in the community who isn't aware of this will be interested.

Finally, this is the sort of thing that'd be really cool to see a presentation on at ORCONF, an open source digital design conference with a reasonably broad scope these days, and we'll definitely be in touch to ask you guys to come along and talk next year if you can.

Cheers,

Julius


