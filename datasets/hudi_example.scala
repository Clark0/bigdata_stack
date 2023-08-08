import org.apache.hudi.QuickstartUtils._
import scala.collection.JavaConversions._
import org.apache.spark.sql.SaveMode._
import org.apache.hudi.DataSourceReadOptions._
import org.apache.hudi.DataSourceWriteOptions._
import org.apache.hudi.config.HoodieWriteConfig._
import org.apache.hudi.common.model.HoodieRecord

val tableName = "hudi_trips_cow"
val basePath = "s3a://hudi/hudi_trips_cow"
val dataGen = new DataGenerator

val inserts = convertToStringList(dataGen.generateInserts(10))
val df = spark.read.json(spark.sparkContext.parallelize(inserts, 2))
df.write.format("hudi").
  option(TABLE_NAME, tableName).
  options(getQuickstartWriteConfigs).
  option(PRECOMBINE_FIELD_OPT_KEY, "ts").
  option(RECORDKEY_FIELD_OPT_KEY, "uuid").
  option(PARTITIONPATH_FIELD_OPT_KEY, "partitionpath").
  option("hoodie.datasource.write.hive_style_partitioning", "true").
  option("hoodie.datasource.hive_sync.enable", "true").
  option("hoodie.datasource.hive_sync.mode", "hms").
  option("hoodie.datasource.hive_sync.database", "default").
  option("hoodie.datasource.hive_sync.partition_fields", "partitionpath").
  option("hoodie.datasource.hive_sync.metastore.uris", "thrift://hive-metastore:9083").
  mode(Overwrite).
  save(basePath)
