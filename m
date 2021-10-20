From: Rob Herring <robh@kernel.org>
Date: Wed, 20 Oct 2021 13:47:39 -0500
Subject: [OpenRISC] [PATCH 00/12] DT: CPU h/w id parsing clean-ups and
 cacheinfo id support
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
Message-ID: <CAL_JsqLg1=T52MqhsGgmAcRueC_nJdivGg4h+M2Bd8W3fyHCmg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Oct 6, 2021 at 11:43 AM Rob Herring <robh@kernel.org> wrote:
>
> The first 10 patches add a new function, of_get_cpu_hwid(), which parses
> CPU DT node 'reg' property, and then use it to replace all the open
> coded versions of parsing CPU node 'reg' properties.
>
> The last 2 patches add support for populating the cacheinfo 'id' on DT
> platforms. The minimum associated CPU hwid is used for the id. The id is
> optional, but necessary for resctrl which is being adapted for Arm MPAM.
>
> Tested on arm64. Compile tested on arm, x86 and powerpc.
>
> Rob
>
> Rob Herring (12):
>   of: Add of_get_cpu_hwid() to read hardware ID from CPU nodes
>   ARM: Use of_get_cpu_hwid()
>   ARM: broadcom: Use of_get_cpu_hwid()
>   arm64: Use of_get_cpu_hwid()
>   csky: Use of_get_cpu_hwid()
>   openrisc: Use of_get_cpu_hwid()
>   powerpc: Use of_get_cpu_hwid()
>   riscv: Use of_get_cpu_hwid()
>   sh: Use of_get_cpu_hwid()
>   x86: dt: Use of_get_cpu_hwid()
>   cacheinfo: Allow for >32-bit cache 'id'
>   cacheinfo: Set cache 'id' based on DT data

I've fixed up the openrisc error and applied 1-10 to the DT tree.

The cacheinfo part is going to need some more work. I've found I will
need the cache affinity (of possible cpus) as well, so I plan to also
store the affinity instead of looping thru caches and cpus again.

Rob
