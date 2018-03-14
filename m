From: Palmer Dabbelt <palmer@sifive.com>
Date: Wed, 14 Mar 2018 10:28:10 -0700 (PDT)
Subject: [OpenRISC] [PATCH v3 3/5] arm: Convert to
	GENERIC_IRQ_MULTI_HANDLER
In-Reply-To: <alpine.DEB.2.21.1803141806580.2481@nanos.tec.linutronix.de>
Message-ID: <mhng-154bcacc-ddfa-4875-b5c5-e3efc72f3e42@palmer-si-x1c4>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, 14 Mar 2018 10:07:35 PDT (-0700), tglx at linutronix.de wrote:
> On Wed, 7 Mar 2018, Palmer Dabbelt wrote:
>
>> This converts the ARM port to use the recently added
>> GENERIC_IRQ_MULTI_HANDLER, which is essentially just a copy of ARM's
>> existhing MULTI_IRQ_HANDLER.  The only changes are:
>>
>> * handle_arch_irq is now defined in a generic C file instead of an
>>   arm-specific assembly file.
>> * handle_arch_irq is not marked as __ro_after_init.
>
> Why? What prevents the generic implementation from doing so?

Sorry, I guess that should have said "handle_arch_irq was not marked as
__ro_after_init".  The patch set has __ro_after_init for the generic
implementation, which was not the case for the arm version.
