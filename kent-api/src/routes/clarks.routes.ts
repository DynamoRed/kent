import { Router, Request, Response, NextFunction } from "express";
import ResponsesUtil from "@utils/responses.util";
import service from "@services/clarks.service";

const router: Router = Router();

router.get('/', async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    const result = await service.getAllClarks();
	ResponsesUtil.handleResult(res, result);
});

router.post('/', async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    const result = await service.createClark({locationId: req.body.location, latitude: req.body.latitude, longitude: req.body.longitude});
	ResponsesUtil.handleResult(res, result);
});

router.get('/center', async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    const result = await service.getClarksCenter();
	ResponsesUtil.handleResult(res, result);
});

router.get('/:id', async (req: Request, res: Response, next: NextFunction): Promise<void> => {
	let id = req.params.id as string;
	if(!id || !id.match(/^[0-9(a-f|A-F)]{8}-[0-9(a-f|A-F)]{4}-4[0-9(a-f|A-F)]{3}-[89ab][0-9(a-f|A-F)]{3}-[0-9(a-f|A-F)]{12}$/gm)) return ResponsesUtil.invalidParameters(res);

    const result = await service.getClark({id: req.params.id});
	ResponsesUtil.handleResult(res, result);
});

router.put('/:id', async (req: Request, res: Response, next: NextFunction): Promise<void> => {
	let id = req.params.id as string;
	if(!id || !id.match(/^[0-9(a-f|A-F)]{8}-[0-9(a-f|A-F)]{4}-4[0-9(a-f|A-F)]{3}-[89ab][0-9(a-f|A-F)]{3}-[0-9(a-f|A-F)]{12}$/gm)) return ResponsesUtil.invalidParameters(res);

    const result = await service.updateClark({id: req.params.id, locationId: req.body.location, latitude: req.body.latitude, longitude: req.body.longitude});
	ResponsesUtil.handleResult(res, result);
});

router.delete('/:id', async (req: Request, res: Response, next: NextFunction): Promise<void> => {
	let id = req.params.id as string;
	if(!id || !id.match(/^[0-9(a-f|A-F)]{8}-[0-9(a-f|A-F)]{4}-4[0-9(a-f|A-F)]{3}-[89ab][0-9(a-f|A-F)]{3}-[0-9(a-f|A-F)]{12}$/gm)) return ResponsesUtil.invalidParameters(res);

    const result = await service.deleteClark({id: req.params.id});
	ResponsesUtil.handleResult(res, result);
});

router.get('/:id/status', async (req: Request, res: Response, next: NextFunction): Promise<void> => {
	let id = req.params.id as string;
	if(!id || !id.match(/^[0-9(a-f|A-F)]{8}-[0-9(a-f|A-F)]{4}-4[0-9(a-f|A-F)]{3}-[89ab][0-9(a-f|A-F)]{3}-[0-9(a-f|A-F)]{12}$/gm)) return ResponsesUtil.invalidParameters(res);

    const result = await service.getAllClarkStatus({id: req.params.id});
	ResponsesUtil.handleResult(res, result);
});

router.post('/:id/status', async (req: Request, res: Response, next: NextFunction): Promise<void> => {
	let id = req.params.id as string;
	if(!id || !id.match(/^[0-9(a-f|A-F)]{8}-[0-9(a-f|A-F)]{4}-4[0-9(a-f|A-F)]{3}-[89ab][0-9(a-f|A-F)]{3}-[0-9(a-f|A-F)]{12}$/gm)) return ResponsesUtil.invalidParameters(res);

    const result = await service.createClarkStatus({clarkId: req.params.id, type: req.body.type, details: req.body.details});
	ResponsesUtil.handleResult(res, result);
});

router.get('/:id/status/replacement', async (req: Request, res: Response, next: NextFunction): Promise<void> => {
	let id = req.params.id as string;
	if(!id || !id.match(/^[0-9(a-f|A-F)]{8}-[0-9(a-f|A-F)]{4}-4[0-9(a-f|A-F)]{3}-[89ab][0-9(a-f|A-F)]{3}-[0-9(a-f|A-F)]{12}$/gm)) return ResponsesUtil.invalidParameters(res);

    const result = await service.updateClarkReplacementStatus({clarkId: req.params.id});
	ResponsesUtil.handleResult(res, result);
});

/***************************************************************
* NOT ALLOWED METHODS HANDLING
***************************************************************/

router.all('/', async (req: Request, res: Response, next: NextFunction): Promise<void> => ResponsesUtil.methodNotAllowed(res));
router.all('/:id', async (req: Request, res: Response, next: NextFunction): Promise<void> => ResponsesUtil.methodNotAllowed(res));
router.all('/:id/status', async (req: Request, res: Response, next: NextFunction): Promise<void> => ResponsesUtil.methodNotAllowed(res));
router.all('/:id/status/replacement', async (req: Request, res: Response, next: NextFunction): Promise<void> => ResponsesUtil.methodNotAllowed(res));

/**************************************************************/

export { router as ClarkRouter };
