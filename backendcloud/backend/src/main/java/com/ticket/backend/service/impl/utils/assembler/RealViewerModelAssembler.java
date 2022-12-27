package com.ticket.backend.service.impl.utils.assembler;

import com.ticket.backend.pojo.RealViewer;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.RepresentationModelAssembler;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class RealViewerModelAssembler implements RepresentationModelAssembler<RealViewer, EntityModel<RealViewer>> {
    @Override
    public EntityModel<RealViewer> toModel(RealViewer realViewer) {
        return EntityModel.of(realViewer);
    }

    public CollectionModel<EntityModel<RealViewer>> toCollectionModel(List<RealViewer> realViewerList) {
        List<EntityModel<RealViewer>> entityModelList = realViewerList.stream()
                .map(this::toModel)
                .collect(Collectors.toList());

        return CollectionModel.of(entityModelList);
    }
}
