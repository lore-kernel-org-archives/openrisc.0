From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 14 Mar 2017 12:08:33 +0000
Subject: [OpenRISC] [PATCH v3 02/25] openrisc: add cache way information
	to cpuinfo
In-Reply-To: <3e06a16339303016b2c57b350a15afeaa7ba7813.1487702890.git.shorne@gmail.com>
References: <cover.1487702890.git.shorne@gmail.com>
 <3e06a16339303016b2c57b350a15afeaa7ba7813.1487702890.git.shorne@gmail.com>
Message-ID: <CAPKp9uadcs_N82DNbhT+FoizVDBA6xCxee9fGGkER3_3+q9rvA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Feb 21, 2017 at 7:11 PM, Stafford Horne <shorne@gmail.com> wrote:
> From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>
> Motivation for this is to be able to print the way information
> properly in print_cpuinfo(), instead of hardcoding it to one.
>

Any particular reason not to use generic cacheinfo sysfs infrastructure ?

--
Regards,
Sudeep
