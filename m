Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A10913A88A
	for <linux-openrisc@vger.kernel.org>; Fri, 23 Aug 2024 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397816; cv=none; b=jcJD3HT62nqY3IKMSpJ/KIPlMkqz4qZlp3c2xQq/UN1ImofHbudxjN8T3XfuosRFN4n7XKdEymz4kmf+1SW48y2JkmISeq9/qSpYSVY6TJVh3xsgIK8YsIxZQ7JtYxcGqdb5R+Q9dlavTNbjMV/MlQSio0QHdLbo1Gs/FRWlp+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397816; c=relaxed/simple;
	bh=XC0WKjiw6xuLZm4t5+Ke7YJTeROuD5vofetaJPGDI5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwhkS5xc7GLznsTJyc8FOrRpSFMAtdM2RcmcPIV2PpfnitBfqYG5mSdfyW0zDA8SuJiYKkusYapSqm/HsnIF30DSVwYtIOuw5PrW5wZsPdviuHzsoT++NPTrUyAgj/Kmen4SrwODq7fftvkl6zBgFzobiSs30YrisDy3/DdQpcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1shOdp-0003RF-5o; Fri, 23 Aug 2024 09:23:25 +0200
Message-ID: <a90fe9aa-5835-4045-b719-8764cdb037cc@pengutronix.de>
Date: Fri, 23 Aug 2024 09:23:23 +0200
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
To: Stafford Horne <shorne@gmail.com>
Cc: qemu-devel@nongnu.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 linux-openrisc@vger.kernel.org
References: <20240822163838.3722764-1-a.fatoum@pengutronix.de>
 <ZsgsG_WL7TNcM1_l@antec>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <ZsgsG_WL7TNcM1_l@antec>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-openrisc@vger.kernel.org

Hello Stafford,

On 23.08.24 08:28, Stafford Horne wrote:
> Note the distribution list you use here: openrisc@lists.librecores.org
> Is old and we should use linux-openrisc@vger.kernel.org.  I will get the qemu
> maintainer file updated.

So this list is appropriate for all openrisc-related development and not only
for the kernel?

> On Thu, Aug 22, 2024 at 06:38:38PM +0200, Ahmad Fatoum wrote:
>> We used to only have a single UART on the platform and it was located at
>> address 0x90000000. When the number of UARTs was increased to 4, the
>> first UART remained at its location, but instead of being the first one
>> to be registered, it became the last.
>>
>> This caused QEMU to pick 0x90000300 as the default UART, which broke
>> software that hardcoded the address of 0x90000000 and expected its
>> output to be visible when the user configured only a single console.
> 
> This makes sense but what do you mean here by DEFAULT uart?  I guess you mean
> the one connected to qemu's stdout by default?

Yes. I am not keen on the QEMU terminology, but the first registered UART seems
to have a special place. Besides being connected to QEMU's stdio by default,
it's also used to populate /chosen/stdout-path as can be seen when dumping the dtb:

  qemu-system-or1k -kernel /dev/null -machine or1k-sim,dumpdtb=qemu.dtb -nographic


>> This caused regressions[1] in the barebox test suite when updating to a
>> newer QEMU. As there seems to be no good reason to register the UARTs in
>> inverse order, let's register them by ascending address, so existing
>> software can remain oblivious to the additional UART ports.
> 
> This sounds good to me.  I will test this out and queue to qemu after the small
> clarification above.
> 
> Also, I will wait to see if Jason has anything to say.

Sure.

By the way, I botched the RESEND and forgot following two lines:

  Fixes: 777784bda468 ("hw/openrisc: support 4 serial ports in or1ksim")
  Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Let me know if I should resend (provided there's no code changes warranting a v2).

Thanks,
Ahmad

> 
> -Stafford
> 
>> [1]: https://lore.barebox.org/barebox/707e7c50-aad1-4459-8796-0cc54bab32e2@pengutronix.de/T/#m5da26e8a799033301489a938b5d5667b81cef6ad
>> ---
>> v1 -> RESEND:
>>   - expand addressees beyond apparently defunct openrisc@lists.librecores.org
>>
>> NOTE: I am not familiar with QEMU internals, so please let me know
>> if registration in inverse order served a particular purpose.
>> ---
>>  hw/openrisc/openrisc_sim.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
>> index bffd6f721f7b..d147b00e4817 100644
>> --- a/hw/openrisc/openrisc_sim.c
>> +++ b/hw/openrisc/openrisc_sim.c
>> @@ -265,7 +265,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
>>          serial_irq = get_cpu_irq(cpus, 0, irq_pin);
>>      }
>>      serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
>> -                   serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1),
>> +                   serial_hd(uart_idx),
>>                     DEVICE_NATIVE_ENDIAN);
>>  
>>      /* Add device tree node for serial. */
>> -- 
>> 2.39.2
>>
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
