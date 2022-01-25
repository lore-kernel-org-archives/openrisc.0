From: Stafford Horne <shorne@gmail.com>
Date: Tue, 25 Jan 2022 10:19:41 +0900
Subject: [OpenRISC] [PATCH v5 00/13] Glibc OpenRISC port
In-Reply-To: <d3bbc7eb-348f-872c-32ef-fcff7d2f4153@linaro.org>
References: <20220104031414.2416928-1-shorne@gmail.com>
 <87tudt2rpg.fsf@oldenburg.str.redhat.com>
 <d3bbc7eb-348f-872c-32ef-fcff7d2f4153@linaro.org>
Message-ID: <Ye9QLX3znGzPdDDF@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Jan 24, 2022 at 10:54:58AM -0300, Adhemerval Zanella wrote:
> 
> 
> On 24/01/2022 10:23, Florian Weimer via Libc-alpha wrote:
> > * Stafford Horne:
> > 
> >> This is the OpenRISC port for glibc that I have been working on.
> > 
> > The port does not define PI_STATIC_AND_HIDDEN.  Is this really
> > necessary, or just an oversight due to the way the port was constructed
> > (presumably with MIPS as the template)?
> > 
> > PI_STATIC_AND_HIDDEN means that references to static functions and data
> > and symbols with hidden visibility do not need any run-time relocations
> > after the final link, with the build flags used by glibc.
> 
> At least the loader with a simple hello world does not fail with qemu with 
> PI_STATIC_AND_HIDDEN set.
> 
> Staffork, could you confirm it is ok to make or1k use PI_STATIC_AND_HIDDEN?

Yes, this was just an oversight and it didn't show up during testing. I think
this is OK as described or1k does not need runtime relocations for hidden
symbols after the final link.

Shall I make the patch to add configure.ac?  Or do you have that ready to go
already?

-Stafford
