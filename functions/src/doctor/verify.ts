import Axios from "axios";
import { CallableContext } from "firebase-functions/lib/providers/https";
import FormData = require("form-data");

export async function verify(body: any, res: CallableContext ) {
  const jmeno = body['jmeno'];
  const prijmeni = body['prijmeni'];

  const formData = new FormData();
  formData.append('filterPrijmeni', prijmeni);
  formData.append('filterjmeno', jmeno);
  const resp = await Axios.post('https://www.lkcr.cz/seznam-lekaru-426.html', formData, {
    headers: formData.getHeaders(),
  });

  const string = resp.data.toString();

  const start = string.lastIndexOf("?filterId=")
  const end = string.lastIndexOf(";do[load]=1");
  const id = string.substr(start  ,end-start);
  const url = 'https://www.lkcr.cz/seznam-lekaru-426.html' + id + '&do[load]=1';
  const respfinal = await Axios.get(url);

  const stringev = respfinal.data.toString();
  const startev = stringev.lastIndexOf('class="evcislo"')
  const ev = stringev.substr(startev  ,50);
  const replace = ev.replace('class="evcislo">Evidenční číslo: ', '');
  const evfinal = replace.replace('</div>', '');
  return evfinal;
}