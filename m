From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Date: Tue, 14 Mar 2017 15:11:23 +0200
Subject: [OpenRISC] [PATCH v3 02/25] openrisc: add cache way information
	to cpuinfo
In-Reply-To: <CAPKp9uadcs_N82DNbhT+FoizVDBA6xCxee9fGGkER3_3+q9rvA@mail.gmail.com>
References: <cover.1487702890.git.shorne@gmail.com>
 <3e06a16339303016b2c57b350a15afeaa7ba7813.1487702890.git.shorne@gmail.com>
 <CAPKp9uadcs_N82DNbhT+FoizVDBA6xCxee9fGGkER3_3+q9rvA@mail.gmail.com>
Message-ID: <20170314131119.GA10854@chokladfabriken.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Mar 14, 2017 at 12:08:33PM +0000, Sudeep Holla wrote:
> On Tue, Feb 21, 2017 at 7:11 PM, Stafford Horne <shorne@gmail.com> wrote:
> > From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> >
> > Motivation for this is to be able to print the way information
> > properly in print_cpuinfo(), instead of hardcoding it to one.
> >
> 
> Any particular reason not to use generic cacheinfo sysfs infrastructure ?
> 

No reason as far as I can see, the creation of this patch predates the
generic cacheinfo sysfs infrastructure.

The patch itself doesn't add cache information to cpuinfo though,
only corrects a bug in the information that is already there.

We should look into exposing the info in the generic cache info sysfs
and potentially removing the information from cpuinfo.

Stefan
