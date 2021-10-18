From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 18 Oct 2021 14:27:53 +0100
Subject: [OpenRISC] [PATCH 04/12] arm64: Use of_get_cpu_hwid()
In-Reply-To: <20211006164332.1981454-5-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-5-robh@kernel.org>
Message-ID: <20211018132753.4md4xlerul3odxji@bogus>
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

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
