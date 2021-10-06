From: Rob Herring <robh@kernel.org>
Date: Wed,  6 Oct 2021 11:43:31 -0500
Subject: [OpenRISC] [PATCH 11/12] cacheinfo: Allow for >32-bit cache 'id'
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
Message-ID: <20211006164332.1981454-12-robh@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

In preparation to set the cache 'id' based on the CPU h/w ids, allow for
64-bit bit 'id' value. The only case that needs this is arm64, so
unsigned long is sufficient.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/base/cacheinfo.c  | 8 +++++++-
 include/linux/cacheinfo.h | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index dad296229161..66d10bdb863b 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -366,13 +366,19 @@ static ssize_t file_name##_show(struct device *dev,		\
 	return sysfs_emit(buf, "%u\n", this_leaf->object);	\
 }
 
-show_one(id, id);
 show_one(level, level);
 show_one(coherency_line_size, coherency_line_size);
 show_one(number_of_sets, number_of_sets);
 show_one(physical_line_partition, physical_line_partition);
 show_one(ways_of_associativity, ways_of_associativity);
 
+static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n", this_leaf->id);
+}
+
 static ssize_t size_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 2f909ed084c6..b2e7f3e40204 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -48,7 +48,7 @@ extern unsigned int coherency_max_size;
  * keeping, the remaining members form the core properties of the cache
  */
 struct cacheinfo {
-	unsigned int id;
+	unsigned long id;
 	enum cache_type type;
 	unsigned int level;
 	unsigned int coherency_line_size;
-- 
2.30.2

