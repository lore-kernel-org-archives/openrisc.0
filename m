From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Apr 2017 01:01:37 -0700
Subject: [OpenRISC] [Qemu-devel] [PATCH 3/7] target/openrisc: add
 numcores and coreid support
In-Reply-To: <f8e2371c7a99cc6694b65d5be4f6c265dceae66a.1492384862.git.shorne@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
 <f8e2371c7a99cc6694b65d5be4f6c265dceae66a.1492384862.git.shorne@gmail.com>
Message-ID: <a0337476-529d-9efe-c4c2-5e63c9aa5ed7@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 04/16/2017 04:23 PM, Stafford Horne wrote:
> These are used to identify the processor in SMP system.  Their
> definition has been defined in verilog cores but it not yet part of the
> spec but it will be soon.
>
> The proposal for this is available:
>   https://openrisc.io/proposals/core-identifier-and-number-of-cores
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~

