From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 6 Oct 2021 19:24:50 -0700
Subject: [OpenRISC] [PATCH 00/12] DT: CPU h/w id parsing clean-ups and
 cacheinfo id support
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
Message-ID: <1a15bbef-cf3d-33c6-b6c1-3dd607d71d1d@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 10/6/2021 9:43 AM, Rob Herring wrote:
> The first 10 patches add a new function, of_get_cpu_hwid(), which parses
> CPU DT node 'reg' property, and then use it to replace all the open
> coded versions of parsing CPU node 'reg' properties.
> 
> The last 2 patches add support for populating the cacheinfo 'id' on DT
> platforms. The minimum associated CPU hwid is used for the id. The id is
> optional, but necessary for resctrl which is being adapted for Arm MPAM.
> 
> Tested on arm64. Compile tested on arm, x86 and powerpc.

On ARM and ARM64:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

lscpu -C continues to work on ARM64 as before with cache properties 
provided in the FDT.
-- 
Florian
