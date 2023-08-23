import { AedStatusTypes } from "@app/core/utils/enums/aed-status-types.enum";

export class AedStatusUtil {
	static toText(status: AedStatusTypes){
		return status === AedStatusTypes.FUNCTIONAL ? '_Functional_' : status === AedStatusTypes.MINOR_ERROR ? '_Minor_Error_' : status === AedStatusTypes.MAJOR_ERROR ? '_Major_Error_' : '_Offline_';
	}
}
