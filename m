From: Shea Levy <shea@shealevy.com>
Date: Sat, 24 Mar 2018 13:44:42 -0400
Subject: [OpenRISC] [PATCH 00/16] Generic infrastructure for unloading
	initramfs
Message-ID: <20180324174458.26423-1-shea@shealevy.com>
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

