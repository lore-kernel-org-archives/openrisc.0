From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 6 Oct 2021 19:24:58 -0700
Subject: [OpenRISC] [PATCH 03/12] ARM: broadcom: Use of_get_cpu_hwid()
In-Reply-To: <20211006164332.1981454-4-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-4-robh@kernel.org>
Message-ID: <ad0c1e14-62f9-0b9c-0b84-d31a213d53de@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 10/6/2021 9:43 AM, Rob Herring wrote:
> Replace open coded parsing of CPU nodes 'reg' property with
> of_get_cpu_hwid().
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
