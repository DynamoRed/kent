import { Router, Request, Response, NextFunction } from "express";
import ResponsesUtil from "@utils/responses.util";
import service from "@services/statuses.service";

const router: Router = Router();

router.get('/', async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    const result = await service.getAllStatuses();
	ResponsesUtil.handleResult(res, result);
});

/***************************************************************
* NOT ALLOWED METHODS HANDLING
***************************************************************/

router.all('/', async (req: Request, res: Response, next: NextFunction): Promise<void> => ResponsesUtil.methodNotAllowed(res));

/**************************************************************/

export { router as StatusesRouter };
