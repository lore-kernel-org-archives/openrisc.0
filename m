From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Thu, 27 Feb 2020 13:26:54 +0100
Subject: [OpenRISC] [PATCH 0/3] OpenRISC clone3 support
In-Reply-To: <20200226225625.28935-1-shorne@gmail.com>
References: <20200226225625.28935-1-shorne@gmail.com>
Message-ID: <20200227122654.ad2tbrohm6ot7pes@wittgenstein>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 27, 2020 at 07:56:22AM +0900, Stafford Horne wrote:
> This series fixes the clone3 not implemented warnings I have been seeing
> during recent builds.  It was a simple case of implementing copy_thread_tls
> and turning on clone3 generic support.  Testing shows no issues.

This all looks good to me. Thanks for doing this. We're getting closer
and closer to having all architectures supporting clone3()!

You want me to pick this series up for 5.7 or are you going through
another tree?

Christian
