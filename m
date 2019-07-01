From: Nancy Chauhan <nancychn1@gmail.com>
Date: Mon, 1 Jul 2019 17:52:06 +0530
Subject: [OpenRISC] [GSoC 2019] Coding Phase 2 : Continuous Integration for
 Hardware Projects on LibreCores CI (Nancy Chauhan)
Message-ID: <CAF69GoqLtjD3jySOto4Fu3N9PRb1Ji5CyNHK7ScYvv+bOeiYKg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello all,

This mail is to summarize the plan for Coding phase 2 of GSoC 2019. I will
be working to Create CI for Yosys synthesis
<http://www.clifford.at/yosys/>required
for monitoring resource usages in mor1kx
<https://github.com/Nancy-Chauhan/mor1kx> and also might further extend CI
for Ysoys synthesis if possible for place and route (
https://github.com/YosysHQ/arachne-pnr
). The plan will be reached to work even on Creating CI for OpenOCD/GDB
 for CPU pipeline debugging in mor1kx  and extending Jenkinsfile (
https://github.com/openrisc/mor1kx/pull/84 ) in mor1kx to make Ysoys and
OpenOCD/GDB part of the build pipeline. It can be added to ci.librecores.org
so that Pull request builder runs for the repository mor1kx .
We can later  Detach reusable logic of mor1kx to
https://github.com/librecores/librecores-pipeline-lib
.

The question I have is whether should we keep all these new additions in
current Travis flow (
https://github.com/openrisc/mor1kx/blob/master/.travis.yml
) also ?


Thank you ,
Nancy Chauhan

Chats on : https://gitter.im/librecores/librecores-ci
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190701/d74dc9ca/attachment.html>
