From: Stafford Horne <shorne@gmail.com>
Date: Fri, 7 Sep 2018 20:27:34 +0900
Subject: [OpenRISC] OpenRISC GCC requirements
Message-ID: <CAAfxs77YuyjFts4h1ZECHoCV=kw3Y2LGy9k8dVQ_i9v1HobD_A@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

As many of us know OpenRISC has different classes for instructions.
i.e. Class I and Class II.

The Class I instructions are required for all implementation and Class
II instructions are optional.   For the new GCC port I have used a few
class II instructions.

Does anyone have any opinion if this would be bad or cause issues?  To
me I think its OK as I haven't seen a core without these.

Class II Instructions used:
       l.extbs  - sign extend byte
       l.extbz  - zero extend byte
       l.exths  - sign extend half-word
       l.exthz  - zero extend half-word
       l.cmov  - conditional move


The alternative would be to substitute the instructions with something
else.   But I don't expect there would be many/any cores running C
code that would be missing these instructions.

-Stafford
