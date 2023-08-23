import DatabaseUtil from "@utils/database.util";
import { Status } from "@models/status.model";
import { QueryReturn } from "@utils/interfaces/query/return.interface";

export default class ShopService {

    static async getAllStatuses(): Promise<QueryReturn<Status[]>> {
        return await DatabaseUtil.queryF<Status[]>("f_get_statuses", [], 'statuses');
    }
};
