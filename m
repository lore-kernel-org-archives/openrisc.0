From: Simon Cook <simon.cook@embecosm.com>
Date: Fri, 26 Jun 2020 18:07:28 +0100
Subject: [OpenRISC] Binary builds of or1k newlib toolchain?
In-Reply-To: <c780c80d-18a8-9ba1-1bf2-5c10ea7c6b34@philipp-wagner.com>
References: <c780c80d-18a8-9ba1-1bf2-5c10ea7c6b34@philipp-wagner.com>
Message-ID: <4fabc84a-ee0e-d36b-52e6-555ccccf0045@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Philipp,

I'm not sure if somewhere has pre-built toolchains already for the
latest stable releases, but I've now started to do weekly builds of
OpenRISC bare metal toolchains based on top of tree:

https://www.embecosm.com/resources/tool-chain-downloads/#openrisc

Our build machines generate a new set of toolchains every Sunday
morning, and then I update that webpage on Monday morning if the tools
look good, so that page should be pretty up to date.

I'll probably build and publish some toolchains based on the 10.1 stable
release early next week, but if bleeding edge is good there are some
there now. Toolchains for those running macOS or Windows will appear at
the same time.

I've tested these with the GCC regression and they look ok, but if
anything looks horribly wrong let me know and I can update build steps
for the next weeks build.

Thanks,
Simon

On 22/06/2020 10:06, Philipp Wagner wrote:
> Hi,
> 
> With OpTiMSoC, we previously used prebuilt GCC/newlib toolchains from
> https://github.com/openrisc/newlib/releases.
> 
> Now that everything is upstream, is there another place for pre-built
> toolchains?
> 
> 
> Thanks!
> 
> Philipp
