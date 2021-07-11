From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 11 Jul 2021 06:24:50 -0700
Subject: [OpenRISC] Maybe another or1k bug
In-Reply-To: <D68EB4FF-538F-4FF1-ACFC-24AFEB098314@benettiengineering.com>
References: <YOdxwtNeQ2eUr+L3@antec>
 <D68EB4FF-538F-4FF1-ACFC-24AFEB098314@benettiengineering.com>
Message-ID: <16b3a02d-f749-0806-ed0f-df3ad7050bb3@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 7/11/21 1:36 AM, Giulio Benetti wrote:
> Substituting SYMBOL_REFERENCES_LOCAL with SYMBOL_CALLS_LOCAL fixes the problem.
> Only one thing, is it valid for every case in that switch or must it be only for R_OR1K_INSN_REL_26?

Only for INSN_REL_26.


r~
