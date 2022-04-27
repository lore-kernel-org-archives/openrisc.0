From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Wed, 27 Apr 2022 19:44:02 +0200
Subject: [OpenRISC] [Qemu-devel] [PATCH 2/7] target/openrisc: add
 shutdown logic
In-Reply-To: <fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
 <fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
Message-ID: <YmmA4li384azQ2i9@zx2c4.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hey Stafford,

On Mon, Apr 17, 2017 at 08:23:51AM +0900, Stafford Horne wrote:
> In openrisc simulators we use hooks like 'l.nop 1' to cause the
> simulator to exit.  Implement that for qemu too.
> 
> Reported-by: Waldemar Brodkorb <wbx@openadk.org>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

I'm curious as to why this never got merged. I noticed I'm entirely able
to shutdown or to reboot (which is mostly what I care about) Linux from
OpenRISC. It just hangs.

Thanks,
Jason
