From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 18 Oct 2021 14:26:05 +0100
Subject: [OpenRISC] [PATCH 01/12] of: Add of_get_cpu_hwid() to read
 hardware ID from CPU nodes
In-Reply-To: <20211006164332.1981454-2-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-2-robh@kernel.org>
Message-ID: <20211018132605.jh2huoxmywjcr5xa@bogus>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Oct 06, 2021 at 11:43:21AM -0500, Rob Herring wrote:
> There are various open coded implementions parsing the CPU node 'reg'
> property which contains the CPU's hardware ID. Introduce a new function,
> of_get_cpu_hwid(), to read the hardware ID.
>
> All the callers should be DT only code, so no need for an empty
> function.
>

Thanks for doing this. I postponed and forgot about this though I had
planned for this when I touched code around this.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
