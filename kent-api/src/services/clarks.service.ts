import DatabaseUtil from "@utils/database.util";
import { Clark } from "@models/clark.model";
import { Status } from "@models/status.model";
import { QueryReturn } from "@utils/interfaces/query/return.interface";

export default class ShopService {

    static async getAllClarks(): Promise<QueryReturn<Clark[]>> {
        return await DatabaseUtil.queryF<Clark[]>("f_get_clarks", [], 'clarks');
    }

    static async getAllClarkStatus(options: { id: string; }): Promise<QueryReturn<Status[]>> {
        return await DatabaseUtil.queryF<Status[]>("f_get_statuses", [options.id], 'statuses');
    }

    static async getClarksCenter(): Promise<QueryReturn<{ lat: number; lng: number; }>> {
        return await DatabaseUtil.queryF<{ lat: number; lng: number; }>("f_get_centered_coords", [], 'coords');
    }



    static async getClark(options: { id: string; }): Promise<QueryReturn<Clark>> {
        return await DatabaseUtil.queryF<Clark>("f_get_clark", [options.id], 'clark');
    }

	static async createClark(options: { locationId: number, latitude: number, longitude: number; }): Promise<QueryReturn<Clark>> {
        return await DatabaseUtil.queryF<Clark>("f_create_clark", [options.locationId, options.latitude, options.longitude], 'clark');
    }

	static async updateClark(options: { id: string; locationId: number, latitude: number, longitude: number; }): Promise<QueryReturn<Clark>> {
        return await DatabaseUtil.queryF<Clark>("f_update_clark", [options.id, options.locationId, options.latitude, options.longitude], 'clark');
    }

	static async deleteClark(options: { id: string; }): Promise<QueryReturn<any>> {
        return await DatabaseUtil.queryF<any>("f_delete_clark", [options.id], '');
    }



	static async createClarkStatus(options: { clarkId: string; type: number; details: string }): Promise<QueryReturn<Status>> {
        return await DatabaseUtil.queryF<Status>("f_create_clark_status", [options.clarkId, options.type, options.details], 'status');
    }

	static async updateClarkReplacementStatus(options: { clarkId: string; }): Promise<QueryReturn<Status>> {
        return await DatabaseUtil.queryF<Status>("f_update_clark_replacement_status", [options.clarkId], 'status');
    }
};
