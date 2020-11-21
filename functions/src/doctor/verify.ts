import Axios from "axios";
import { Request } from "firebase-functions";
import { CallableContext } from "firebase-functions/lib/providers/https";
import FormData = require("form-data");

export async function verify(req: Request, res: CallableContext ) {
  const body = JSON.parse(req.body);
  const jmeno = body['jmeno'];
  const prijmeni = body['prijmeni'];

  const formData = new FormData();
  formData.append('filterPrijmeni', prijmeni);
  formData.append('filterjmeno', jmeno);
  const resp = await Axios.post('https://www.lkcr.cz/seznam-lekaru-426.html', formData, {
    headers: formData.getHeaders()
  });

  var string = resp.data.toString();

  var start = string.lastIndexOf("?filterId=")
  var end = string.lastIndexOf(";do[load]=1");
  var id = string.substr(start  ,end-start);
  const url = 'https://www.lkcr.cz/seznam-lekaru-426.html' + id + '&do[load]=1';
  const respfinal = await Axios.get(url);

  const stringev = respfinal.data.toString();
  var startev = stringev.lastIndexOf('class="evcislo"')
  var ev = stringev.substr(startev  ,50);
  var replace = ev.replace('class="evcislo">Evidenční číslo: ', '');
  var evfinal = replace.replace('</div>', '');
  return evfinal;
}