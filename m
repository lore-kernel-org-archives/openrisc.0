From: Stafford Horne <shorne@gmail.com>
Date: Mon, 20 Mar 2017 23:12:47 +0900
Subject: [OpenRISC] Linux kernel upstreaming status
In-Reply-To: <D90E780DD5090A4F9AEBC859615CED7701150239AF@OXYGEN.aacmicrotec.local>
References: <20170319223210.GR2418@lianli.shorne-pla.net>
 <D90E780DD5090A4F9AEBC859615CED7701150239AF@OXYGEN.aacmicrotec.local>
Message-ID: <20170320141247.GB2570@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Mon, Mar 20, 2017 at 07:53:36AM +0000, Jakob Viketoft wrote:
> Hello,
> 
> ________________________________________
> From: OpenRISC [openrisc-bounces at lists.librecores.org] on behalf of Stafford Horne [shorne at gmail.com]
> Sent: Sunday, March 19, 2017 23:32
> To: Openrisc
> Subject: [OpenRISC] Linux kernel upstreaming status
> 
> >  * What is the scet driver?
> 
> I might be able to shed some light on this at least. It's the SpaceCraft Elapsed Timer, essentially a dead reckoning counter from the moment of power-on. This can be adjusted to match the current clock and so provide a system time, although it only got a resolution of 15.3 us since it's using subseconds (1/2^16th of a second) and not normal milli/microseconds or something similar. As for its inclusion in the Linux tree, I don't know if anyone else uses this. We have switched to RTEMS for all future work and bare-metal for all the previous ones and aren't really using any Linux parts anymore. The SCET implementation has also changed and that driver doesn't match our hardware at all anymore.
> 
> What I'm saying is that if there's no one else interested in this, I'd suggest you scrap it.

Thanks Jakob,

That's very informative.

-Stafford

> Best regards,
> 
>        /Jakob
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
> 
