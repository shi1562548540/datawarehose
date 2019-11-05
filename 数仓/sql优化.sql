1.去重使用row_number(),不适用distinct
2.做join时，要做map join，将小表加载到内存中/*+ MAPJOIN(b)*/。
3.