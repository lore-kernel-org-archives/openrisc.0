From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 18 Oct 2021 14:31:27 +0100
Subject: [OpenRISC] [PATCH 12/12] cacheinfo: Set cache 'id' based on DT
 data
In-Reply-To: <20211006164332.1981454-13-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-13-robh@kernel.org>
Message-ID: <20211018133127.4oenrvzxwzn73s3k@bogus>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Oct 06, 2021 at 11:43:32AM -0500, Rob Herring wrote:
> Use the minimum CPU h/w id of the CPUs associated with the cache for the
> cache 'id'. This will provide a stable id value for a given system. As
> we need to check all possible CPUs, we can't use the shared_cpu_map
> which is just online CPUs. As there's not a cache to CPUs mapping in DT,
> we have to walk all CPU nodes and then walk cache levels.
> 

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
