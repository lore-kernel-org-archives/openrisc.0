From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 18 Oct 2021 14:30:04 +0100
Subject: [OpenRISC] [PATCH 11/12] cacheinfo: Allow for >32-bit cache 'id'
In-Reply-To: <20211006164332.1981454-12-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-12-robh@kernel.org>
Message-ID: <20211018133004.7pcbfdsvrjgjitpj@bogus>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Oct 06, 2021 at 11:43:31AM -0500, Rob Herring wrote:
> In preparation to set the cache 'id' based on the CPU h/w ids, allow for
> 64-bit bit 'id' value. The only case that needs this is arm64, so
> unsigned long is sufficient.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
