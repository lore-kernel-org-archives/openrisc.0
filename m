From: Will Deacon <will@kernel.org>
Date: Thu, 7 Oct 2021 09:07:59 +0100
Subject: [OpenRISC] [PATCH 04/12] arm64: Use of_get_cpu_hwid()
In-Reply-To: <20211006164332.1981454-5-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-5-robh@kernel.org>
Message-ID: <20211007080758.GA31467@willie-the-truck>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Oct 06, 2021 at 11:43:24AM -0500, Rob Herring wrote:
> Replace the open coded parsing of CPU nodes' 'reg' property with
> of_get_cpu_hwid().
> 
> This change drops an error message for missing 'reg' property, but that
> should not be necessary as the DT tools will ensure 'reg' is present.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/kernel/smp.c | 31 ++-----------------------------
>  1 file changed, 2 insertions(+), 29 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

It's a shame INVALID_HWID can't be removed too, but looks like it's still
used in a couple of places.

Will
