From: Stafford Horne <shorne@gmail.com>
Date: Sun, 22 Oct 2017 11:46:38 +0900
Subject: [OpenRISC] [PATCH 0/3] OpenRISC doc updates
Message-ID: <20171022024641.28478-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

This series moves OpenRISC documentation out of the arch/ folder and into the
Documentation folder.  I have also done some updates the README to bring to
better match the current state of OpenRISC.

Also, this adds documentation to the openrisc,or1ksim device tree binding which
was previously not documented.

Stafford Horne (3):
  Documentation: Move OpenRISC docs out of arch/
  Documentation: openrisc: Updates to README
  openrisc: dts: Add OpenRISC platform SoC

 .../bindings/openrisc/opencores/or1ksim.txt        | 39 +++++++++++++
 .../openrisc/README                                | 65 +++++++++++++---------
 .../TODO.openrisc => Documentation/openrisc/TODO   |  0
 MAINTAINERS                                        |  2 +
 4 files changed, 79 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/openrisc/opencores/or1ksim.txt
 rename arch/openrisc/README.openrisc => Documentation/openrisc/README (56%)
 rename arch/openrisc/TODO.openrisc => Documentation/openrisc/TODO (100%)

-- 
2.13.6

