import { BigQuery } from "@google-cloud/bigquery";
import { CallableContext } from "firebase-functions/lib/providers/https";
const bigquery = new BigQuery();

export async function search(body: any, res: CallableContext ) {
  const name = body['name'];
  const query = 'SELECT * FROM `piller-cee.drugs.box_infromation` WHERE lp_nazev LIKE ' + `"%${name}%"`;
  const options = {
    query: query,
    location: 'europe-west3',
  };
  const [job] = await bigquery.createQueryJob(options);
  const [rows] = await job.getQueryResults();
  return JSON.stringify(rows);
}