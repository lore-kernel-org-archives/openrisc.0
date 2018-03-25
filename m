From: Shea Levy <shea@shealevy.com>
Date: Sun, 25 Mar 2018 18:18:37 -0400
Subject: [OpenRISC] [PATCH v2 00/16] Generic infrastructure for unloading
	initramfs
In-Reply-To: <20180324174458.26423-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
Message-ID: <20180325221853.10839-1-shea@shealevy.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This patch series extracts out code for unloading the initramfs that
was identical across 14 architectures, and moves those architectures
to the common code path. Additionally, RISC-V is newly moved to the
common code path.

In addition to reducing duplication, this allows us to bring future
improvements (such as generalizing existing "keep initrd" command line
options) to multiple architectures at once.

v2: Mark generic free_initrd_mem __init.

